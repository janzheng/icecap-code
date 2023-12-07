import "encoding/csv"
import "encoding/json"
import "list"
import "strings"






// simple example
// save this as ice_cream.cue
// cue export ice_cream.cue -e encoded -o text:ice_cream.csv -f


_maxCones: 5
_maxScoops: 3
_flavors: ["vanilla", "chocolate", "strawberry", "banana"]
_flavorStr: strings.Join([for f in _flavors {"\(f),\(f)"}], " | ")
_forms: #Forms & {
    dynamic_ice_cream: [
        {dyn_record_id: #Form & { // necessary for every data dict
            "Field Label": "Record ID" // used as label for dashboard
        }},
        {dyn_num_cones: #Form & {
            "Field Type": "text"
            "Field Label": "How many cones?"
            "Text Validation Type OR Show Slider Number": "integer"
            "Text Validation Max": _maxCones
            "Required Field?": "y"
        }},
        for x, X in _maxCones*[""] {
            "dyn_num_scoops_cone_\(x+1)": #Form & {
                "Field Type": "text"
                "Field Label": "How many scoops for cone \(x+1)?"
                "Text Validation Type OR Show Slider Number": "integer"
                "Text Validation Max": _maxScoops
                "Branching Logic (Show field only if...)": "[dyn_num_cones] > \(x)"
                "Required Field?": "y"
            }
        },
        for x, X in _maxCones*[""] {
            for y, Y in _maxScoops*[""] {
                "dyn_flavor_cone\(x+1)_scoop\(y+1)": #Form & {
                    "Field Type": "radio"
                    "Field Label": "What flavor do you want for cone \(x+1), scoop \(y+1)?"
                    "Choices, Calculations, OR Slider Labels": _flavorStr
                    "Branching Logic (Show field only if...)": "[dyn_num_cones] > \(x) and [dyn_num_scoops_cone_\(x+1)] > \(y)"
                    "Required Field?": "y"
                }
            }
        }
    ],
}










#Form: {
        // every field here is required in the output, and will default to ""
        
        // uses field name as the object/key name
        "Variable / Field Name":                      string
        
        // fields with same form name are grouped in the same form
        "Form Name":                                  string
        
        // creates a hr / header label above the field
        "Section Header":                             string | *""
        
        "Field Type":                                 string
        "Field Type":                                 *"text" | "notes" | "dropdown" | "radio" | "checkbox" | "calc" | "file"
        
        "Field Label":                                string
        
        // TODO: expand in v2
        "Choices, Calculations, OR Slider Labels":    string | *""
        
        // Appears under the entry form; cosmetic
        "Field Note":                                 string | *""
        
        "Text Validation Type OR Show Slider Number": string | *""
        
        // TODO: these need to match validation type; e.g. if type is "number" this can only be number
        "Text Validation Min":                        number | int | *""
        "Text Validation Max":                        number | int | *""
        
        // is it PII? "y" = true, "" (blank) = false
        "Identifier?":                                string | "y" | *""
        
        // example: [field_name] > 0
        // note: equals comparisons need to be wrapped in " — [field] = "5"
        // multiple choice checkbox are confusing: [field(option_name)] = "1"; 
        // option_name can be a number or string;
        // "1" means "is selected" / true
        // TODO: field_name needs to exist as a key in the rest of the fields
        "Branching Logic (Show field only if...)":    string | *""
        
        
        "Required Field?":                            string | "y" | *""
        
        // TODO: figure out options
        "Custom Alignment":                           ""
        
        // identifier for survey
        "Question Number (surveys only)":             string | *""
        
        // for checkboxes + radios; if supply a name, will assemble questions
        // into a grid of likert-scale choices
        // TODO: validate these
        "Matrix Group Name":                          string | *""
    }

#Forms: {
    [FormName=_]: [... {
        [Name=_]: #Form & {
            // uses field name as the object/key name
            "Variable / Field Name":                      Name
        
            // fields with same form name are grouped in the same form
            "Form Name":                                  FormName
        }
    }]
}





















_listOfFieldNames: list.FlattenN([ for fields in _forms { 
    [for field in fields { 
        // field
        [for fName in field {
            fName
        }]
    }]
}], 3)



_header: [ for k, _ in _listOfFieldNames[0] { k } ]
_values: [ for _, elem in _listOfFieldNames { [for _, v in elem { v } ] } ]
csvlist: [_header] + _values
encoded: strings.Trim(csv.Encode(csvlist), "\n")

