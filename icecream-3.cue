// Scenario 3: ice cream shop
// save this as ice_cream.cue
// ./cue export icecream-3.cue -e encoded -o text:icecream-3.csv -f

import "encoding/csv"
import "encoding/json"
import "list"
import "strings"
import "math"


_maxOrders: 10
_maxScoops: 3

_forms: #Forms & {
  "icecream_scenario_3": [
    {icecream_id: #Form & {
       label: "Ice Cream ID"
    }},
    {s3_num_orders: #Form & {
      type: "text"
      label: "How many orders?"
      validator: "integer"
      fieldnote: "Max orders: \(_maxOrders)"
      max: _maxOrders
      min: 0
      req: "y"
    }},

    for x, X in _maxOrders*[""] {
        "s3_order\(x+1)_name": #Form & {
          type: "text"
          section: "Order #\(x+1) [s3_order\(x+1)_name]"
          label: "[Order #\(x+1)] Name on the order"
          branch: "[s3_num_orders] > \(x)"
          req: "y"
        },
        "s3_order\(x+1)_cup_cone": #Form & {
          type: "radio"
          label: "[Order #\(x+1)] Cup or Cone for [s3_order\(x+1)_name]?"
          choices: "cup,cup | cone,cone"
          branch: "[s3_num_orders] > \(x) and [s3_order\(x+1)_name]"
          req: "y"
        },
        "s3_order\(x+1)_flavor": #Form & {
          type: "radio"
          label: "[Order #\(x+1)] What flavor does [s3_order\(x+1)_name] want?"
          choices: "vanilla, vanilla | chocolate, chocolate | strawberry, strawberry"
          branch: "[s3_num_orders] > \(x) and [s3_order\(x+1)_name]"
          req: "y"
        },
        "s3_order\(x+1)_scoops": #Form & {
          type: "text"
          label: "[Order #\(x+1)] How many scoops does [s3_order\(x+1)_name] want?"
          validator: "integer"
          max: _maxScoops
          branch: "[s3_num_orders] > \(x) and [s3_order\(x+1)_name]"
          fieldnote: "Max scoops: \(_maxScoops)"
          req: "y"
        },
    },
  ]
}













// keep for reference; these are added as Instruments

// _forms: #Forms & {
//   "icecream_scenario_2": [
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
//     "icecream_scenario_1": [
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