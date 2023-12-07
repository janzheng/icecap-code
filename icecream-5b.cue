// Scenario 5: fancy hipster ice cream franchise ordering form
// 5b: update to REDCap prevents nesting field embeddings :(

// save this as ice_cream.cue
// cue export icecream-5b.cue -e encoded -o text:icecream-5b.csv -f

import "encoding/csv"
import "encoding/json"
import "list"
import "strings"
import "math"


_maxOrders: 5
_maxScoops: 9

_flavors: ["vanilla", "chocolate", "strawberry", "banana", "chocolate chunk", "chocolate peanut butter", "moose tracks", "black cherry", "mint chocolate chip", "lingonberry", "salmonberry", "starfruit", "halloween", "salmon", "butter chicken", "licorice", "butter", "kangaroo"]
_flavorsVars: [for f in _flavors {strings.Replace(f," ","_",-1)}]
_flavorsKeys: [for f in _flavors {strings.ToTitle(f)}]
_flavorStr: strings.Join([for #,f in _flavorsVars {"\(f),\(_flavorsKeys[#])"}], " | ")

_containers: ["cup,Cup", "cone,Cone", "Waffle, Waffle Cone", "taco, Taco shell", "burrito, Burrito"]
_containersStr: strings.Join([for f in _containers {"\(f)"}], " | ")

_toppings: [
  "sprinkles,Sprinkles",
  "pecan,Pecan Crumbs",
  "almonds,Almond flakes",
  "caramel,Caramel drizzle",
  "chocolate,Chocolate drizzle",
  "ranch,Ranch Dressing",
  "jerky, Beef Jerky"
  ]
_toppingsStr: strings.Join([for f in _toppings {"\(f)"}], " | ")


_forms: #Forms & {

  _card: "\(_mar) border: 2px solid #ccc; border-radius: 4px;"
  _cardBotCutoff: "margin-bottom: 0px; border-bottom: 0; border-bottom-left-radius: 0; border-bottom-right-radius: 0;"
  _cardBot: "margin-bottom: 8px; border-bottom: 2px solid #ccc; border-bottom-left-radius: 4px; border-bottom-right-radius: 4px;"
  _cardTopCutoff: "margin-top: 0px; padding-top: 0px; border-top: 0; border-top-left-radius: 0; border-top-right-radius: 0;"
  _pad: "padding: 16px;"
  _padTopHalf: "padding-top: 8px;"
  _mar: "margin: 16px;"
  _marTopHalf: "margin-top: 8px;"
  
  "ice_cream_scenario_5": [
    {icecream_id: #Form & {
       label: "Ice Cream ID"
    }},

    // designing a form with embedded fields
    {s5_sec_intro: #Form & {
      type: "descriptive"
      label: strings.Replace("""
        <div style="background: white !important;"><br />
          <div><img style="width: 100%; height: 350px; object-fit: cover; object-position: center " src="https://f2.phage.directory/blogalog/dalle-icecap-landscape.jpg" /></div>
          <h1 style="font-weight: 300; text-align: center">🍦🍧🍨 ICECap Creamery 🍦🍧🍨</h1>
          <h3 style="font-weight: 400; padding: 16px; text-align: center">How many ice creams? {s5_num_orders}</h3>
        </div>
        """, "\n","",-1)
    }},
    {s5_num_orders: #Form & {
      type: "text"
      label: "How many orders?"
      validator: "integer"
      fieldnote: "Max orders: \(_maxOrders)"
      max: _maxOrders
      min: 0
      req: "y"
    }},

    for x, X in _maxOrders*[""] {
        "s5_order\(x+1)_fancy_name": #Form & {
          type: "descriptive"
          label: strings.Replace("""
            <div style="background: white !important; \(_pad) \(_card) \(_cardBotCutoff) ">
              <div>Name on order #\(x+1)
                <div style="padding-top: 8px;">{s5_order\(x+1)_name}<div>
              </div>
            </div>
            """, "\n","",-1)
          branch: "[s5_num_orders] > \(x)"
        },
        "s5_order\(x+1)_fancy_basics": #Form & {
          type: "descriptive"
          label: strings.Replace("""
            <div style="background: white !important; \(_card) \(_cardTopCutoff) \(_cardBotCutoff)">
              <div style="display: grid; grid-template-columns: 1fr 1fr;">
                <div style="\(_pad)">Holder:
                  <div style="\(_padTopHalf)">{s5_order\(x+1)_containers}</div>
                </div>
                <div style="\(_pad)">Toppings:
                  <div style="\(_padTopHalf)">{s5_order\(x+1)_toppings}</div>
                </div>
              </div>
              <div style="\(_pad)">How many scoops of ice cream for [s5_order\(x+1)_name]?
                <div>{s5_order\(x+1)_scoops}</div>
              </div>
            </div>
            """, "\n","",-1)
          branch: "[s5_num_orders] > \(x) and [s5_order\(x+1)_name]"
        },


        // NESTED EMBEDS HAVE BEEN DEPRECATED IN 12.5.x
        // "s5_order\(x+1)_fancy_scoops": #Form & {
        //   type: "descriptive"

        //   _scoopEmbeds: strings.Join([for #,$ in (_maxScoops)*[""] {"{s5_order\(x+1)_scoop\(#+1)}"}], " ")
        //   label: strings.Replace("""
        //     <div style="background: white !important; \(_card) \(_cardTopCutoff)">
        //       <div style="display: flex; flex-wrap: wrap;">
        //         <div>
        //           <div style="font-weight: 900">Scoop \(x+1) flavor:</div>
        //           \(_scoopEmbeds)
        //         </div>
        //       </div>
        //     </div>
        //     """, "\n","",-1)
        //   branch: "[s5_num_orders] > \(x) and [s5_order\(x+1)_name] and [s5_order\(x+1)_scoops] > 0 "
        // }

          // the form label needs to appear with the question
          // so we need to add the branch logic + label in a question, that embeds the question itself
          // this way, we can embed a question with a label into somewhere else (REDCap drops the labels otherwise)
          for #,$ in (_maxScoops)*[""] {
            "s5_order\(x+1)_fancy_scoops_\(#+1)": #Form & {
              type: "descriptive"
              label: strings.Replace("""
                <div style="background: white !important; \(_card) \(_cardTopCutoff) \(_cardBotCutoff)">
                  <div style="\(_pad)">Scoop \(#+1) flavor:
                    <div style="\(_padTopHalf)">{s5_order\(x+1)_scoop\(#+1)}</div>
                  </div>
                </div>
              """, "\n","",-1)
              branch: "[s5_num_orders] > \(x) and [s5_order\(x+1)_name] and [s5_order\(x+1)_scoops] > \(#) "
            }
          }

        "s5_order\(x+1)_name": #Form & {
          type: "text"
          // section: "Order #\(x+1) [s5_order\(x+1)_name]"
          label: "[Order #\(x+1)] Name on the order"
          branch: "[s5_num_orders] > \(x)"
          req: "y"
        },
        "s5_order\(x+1)_containers": #Form & {
          type: "radio"
          label: "[Order #\(x+1)] What ice cream container technology for [s5_order\(x+1)_name]?"
          choices: _containersStr
          branch: "[s5_num_orders] > \(x) and [s5_order\(x+1)_name]"
          req: "y"
        },
        "s5_order\(x+1)_toppings": #Form & {
          type: "checkbox"
          label: "[Order #\(x+1)] What toppings does [s5_order\(x+1)_name] want?"
          choices: _toppingsStr
          branch: "[s5_num_orders] > \(x) and [s5_order\(x+1)_name]"
          req: "y"
        },
        "s5_order\(x+1)_scoops": #Form & {
          type: "text"
          label: "[Order #\(x+1)] How many scoops does [s5_order\(x+1)_name] want?"
          validator: "integer"
          max: _maxScoops
          branch: "[s5_num_orders] > \(x) and [s5_order\(x+1)_name]"
          fieldnote: "Max scoops: \(_maxScoops)"
          req: "y"
        },
        for y, Y in _maxScoops*[""] {
          "s5_order\(x+1)_scoop\(y+1)": #Form & {
            type: "radio"
            label: "[Order #\(x+1)] What flavor does [s5_order\(x+1)_name] want for scoop \(y+1)?"
            choices: _flavorStr
            branch: "[s5_num_orders] > \(x) and [s5_order\(x+1)_name] and [s5_order\(x+1)_scoops] > \(y)"
            req: "y"
          }
        },
        "s5_order\(x+1)_bottom": #Form & {
          type: "descriptive"
          label: strings.Replace("""
            <div style="background: white !important; \(_card) \(_cardTopCutoff) \(_cardBot)"><br>
            </div>
            """, "\n","",-1)
          branch: "[s5_num_orders] > \(x)"
        },
    },
  ]
}













// keep for reference; these are added as Instruments


// _forms: #Forms & {
//   "ice_cream_scenario_4": [
//     // {icecream_id: #Form & {
//     //    label: "Ice Cream ID"
//     // }},
//     {s4_num_orders: #Form & {
//       type: "text"
//       label: "How many orders?"
//       validator: "integer"
//       fieldnote: "Max orders: \(_maxOrders)"
//       max: _maxOrders
//       min: 0
//       req: "y"
//     }},

//     for x, X in _maxOrders*[""] {
//         "s4_order\(x+1)_name": #Form & {
//           type: "text"
//           section: "Order #\(x+1) [s4_order\(x+1)_name]"
//           label: "[Order #\(x+1)] Name on the order"
//           branch: "[s4_num_orders] > \(x)"
//           req: "y"
//         },
//         "s4_order\(x+1)_containers": #Form & {
//           type: "radio"
//           label: "[Order #\(x+1)] What ice cream container technology for [s4_order\(x+1)_name]?"
//           choices: _containersStr
//           branch: "[s4_num_orders] > \(x) and [s4_order\(x+1)_name]"
//           req: "y"
//         },
//         "s4_order\(x+1)_toppings": #Form & {
//           type: "checkbox"
//           label: "[Order #\(x+1)] What toppings does [s4_order\(x+1)_name] want?"
//           choices: _toppingsStr
//           branch: "[s4_num_orders] > \(x) and [s4_order\(x+1)_name]"
//           req: "y"
//         },
//         "s4_order\(x+1)_scoops": #Form & {
//           type: "text"
//           label: "[Order #\(x+1)] How many scoops does [s4_order\(x+1)_name] want?"
//           validator: "integer"
//           max: _maxScoops
//           branch: "[s4_num_orders] > \(x) and [s4_order\(x+1)_name]"
//           fieldnote: "Max scoops: \(_maxScoops)"
//           req: "y"
//         },
//         for y, Y in _maxScoops*[""] {
//           "s4_order\(x+1)_scoop\(y+1)": #Form & {
//             type: "radio"
//             label: "[Order #\(x+1)] What flavor does [s4_order\(x+1)_name] want for scoop \(y+1)?"
//             choices: _flavorStr
//             branch: "[s4_num_orders] > \(x) and [s4_order\(x+1)_name] and [s4_order\(x+1)_scoops] > \(y)"
//             req: "y"
//           }
//         },
//     },
//   ]
// }


// _forms: #Forms & {
//   "ice_cream_scenario_3": [
//   //   {icecream_id: #Form & {
//   //      label: "Ice Cream ID"
//   //   }},
//     {s3_num_orders: #Form & {
//       type: "text"
//       label: "How many orders?"
//       validator: "integer"
//       fieldnote: "Max orders: \(_maxOrders)"
//       max: _maxOrders
//       min: 0
//       req: "y"
//     }},

//     for x, X in _maxOrders*[""] {
//         "s3_order\(x+1)_name": #Form & {
//           type: "text"
//           section: "Order #\(x+1) [s3_order\(x+1)_name]"
//           label: "[Order #\(x+1)] Name on the order"
//           branch: "[s3_num_orders] > \(x)"
//           req: "y"
//         },
//         "s3_order\(x+1)_cup_cone": #Form & {
//           type: "radio"
//           label: "[Order #\(x+1)] Cup or Cone for [s3_order\(x+1)_name]?"
//           choices: "cup,cup | cone,cone"
//           branch: "[s3_num_orders] > \(x) and [s3_order\(x+1)_name]"
//           req: "y"
//         },
//         "s3_order\(x+1)_flavor": #Form & {
//           type: "radio"
//           label: "[Order #\(x+1)] What flavor does [s3_order\(x+1)_name] want?"
//           choices: "vanilla, vanilla | chocolate, chocolate | strawberry, strawberry"
//           branch: "[s3_num_orders] > \(x) and [s3_order\(x+1)_name]"
//           req: "y"
//         },
//         "s3_order\(x+1)_scoops": #Form & {
//           type: "text"
//           label: "[Order #\(x+1)] How many scoops does [s3_order\(x+1)_name] want?"
//           validator: "integer"
//           max: _maxScoops
//           branch: "[s3_num_orders] > \(x) and [s3_order\(x+1)_name]"
//           fieldnote: "Max scoops: \(_maxScoops)"
//           req: "y"
//         },
//     },
//   ]
// }


// _forms: #Forms & {
//   "ice_cream_scenario_2": [
//     // {icecream_id: #Form & {
//     //    label: "Ice Cream ID"
//     // }},
//     {s2_num_orders: #Form & {
//       type: "text"
//       label: "How many orders?"
//       validator: "integer"
//       fieldnote: "Max orders: \(_maxOrders)"
//       max: _maxOrders
//       min: 0
//       req: "y"
//     }},

//     for x, X in _maxOrders*[""] {
//         "s2_order\(x+1)_flavor": #Form & {
//           type: "radio"
//           section: "Order #\(x+1)"
//           label: "[Order #\(x+1)] What flavor do you want?"
//           choices: "vanilla, vanilla | chocolate, chocolate | strawberry, strawberry"
//           branch: "[s2_num_orders] > \(x)"
//           req: "y"
//         },
//         "s2_order\(x+1)_cup_cone": #Form & {
//           type: "radio"
//           label: "[Order #\(x+1)] Cup or Cone?"
//           choices: "cup,cup | cone,cone"
//           branch: "[s2_num_orders] > \(x)"
//           req: "y"
//         }
//     },
//   ]
// }



// _forms: #Forms & {
//     "ice_cream_scenario_1": [
//         // {icecream_id: #Form & {
//         //     label: "Ice Cream ID"
//         // }},
//         {flavor: #Form & {
//             type: "radio"
//             label: "What flavor do you want?"
//             choices: "vanilla, vanilla | chocolate, chocolate | strawberry, strawberry"
//         }},
//         {cup_cone: #Form & {
//             type: "radio"
//             label: "Cup or Cone?"
//             choices: "cup,cup | cone,cone"
//         }}
//     ]
// }










// config
#Forms: {
    [FormName=_]: [... {
        [Name=_]: #Form & {
            name: Name
            form: FormName
        }
    }]
}


#Form: {
    // every field here is required in the output, and will default to ""

    // uses field name as the object/key name
    //"Variable / Field Name":                      string
    name: string

    // fields with same form name are grouped in the same form
    form: string

    // creates a hr / header label above the field
    section: string | *""

    // "Field Type"
    type: string | *"text" | "notes" | "dropdown" | "descriptive" | "radio" | "checkbox" | "calc" | "file"

    // "Field Label"
    label: string
    
    // TODO: expand in v2
    // "Choices, Calculations, OR Slider Labels"
    choices: string | *""

    // Appears under the entry form
    // "Field Note"
    fieldnote: string | *""

    // "Text Validation Type OR Show Slider Number"
    validator: string | *"" | "autocomplete" | "date_dmy" | "integer" | "number_1dp" | "date_ymd" | "phone" | "email" | "number"

    // TODO: these need to match validation type; e.g. if type is "number" this can only be number
    // "min"
    min: number | int | *""
    // "max"
    max: number | int | *""

    // is it PII? "y" = true, "" (blank) = false
    // "Identifier?"
    PII: string | "y" | *""


    // example: [field_name] > 0
    // note: equals comparisons need to be wrapped in " — [field] = "5"
    // multiple choice checkbox are confusing: [field(option_name)] = "1"; 
    // option_name can be a number or string;
    // "1" means "is selected" / true
    // TODO: field_name needs to exist as a key in the rest of the fields
    // "Branching Logic (Show field only if...)"
    branch: string | *""

    // "Required Field?"
    req: string | "y" | *""

    // TODO: figure out options
    // "Custom Alignment"
    cAlign: string | *""

    // identifier for survey
    // "Question Number (surveys only)"
    qNum: string | *""


    // for checkboxes + radios; if supply a name, will assemble questions
    // into a grid of likert-scale choices
    // TODO: validate these
    // "Matrix Group Name"
    mxGroup: string | *""
    // "Matrix Ranking?"
    mxRank: string | *""

    // these are the @actions like @CHARLIMIT="50"
    // "Field Annotation"
    action: string | *"" // "field annotation"

    ... // allow other variables
}
// translate min form 
_FormMap: {
    name: "Variable / Field Name"
    form: "Form Name"
    section: "Section Header"
    type: "Field Type"
    label: "Field Label"
    choices: "Choices, Calculations, OR Slider Labels"
    fieldnote: "Field Note"
    validator: "Text Validation Type OR Show Slider Number"
    min: "min"
    max: "max"
    PII: "Identifier?"
    branch: "Branching Logic (Show field only if...)"
    req: "Required Field?"
    cAlign: "Custom Alignment"
    qNum: "Question Number (surveys only)"
    mxGroup: "Matrix Group Name"
    mxRank: "Matrix Group Ranking?"
    action: "Field Annotation"
}



















_listOfFieldNames: list.FlattenN([ for fields in _forms { 
    [for field in fields { 
        [for form in field {
            for _,x in form {"\(_FormMap[_])":x}
        }]
    }]
}], 3)


_header: [ for k, _ in _listOfFieldNames[0] { k } ]
_values: [ for _, elem in _listOfFieldNames { [for _, v in elem { v } ] } ]
csvlist: [_header] + _values
encoded: strings.Trim(csv.Encode(csvlist), "\n")


// create a function that generates CUE @action tags with nested ifs that translate a date like MM-DD-YYYY to the day of year, for the first week of 2023
