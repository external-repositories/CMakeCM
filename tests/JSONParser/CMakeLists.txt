cmake_minimum_required(VERSION 3.5)
project(Test)

set(CMCM_LOCAL_RESOLVE_URL "file://${PROJECT_SOURCE_DIR}/../../")
include(../../CMakeCM.cmake)

include(JSONParser)

file(READ test.json jsonTest)

# name of variable not string itself is passed to macro sbeParseJson
sbeParseJson(example jsonTest)

# Now you can use parsed variables.
foreach (var ${example})
    message("${var} = ${${var}}")
endforeach ()

# when you want to access concrete JSON object, use the names in JSON, the array indexes for JSON object MUST be given after '_'
# e.g if you want to store value of object 'id' of first element of array 'items' in object 'menu'
set(FirstItemId ${example.menu.items_0.id})
# e.g if you want to store 1-th element of array 'short' in object 'label' of 5-th element of array items in object menu
set(ShortLabel ${example.menu.items_5.label.short_0})


add_executable("${example.exeName}" "${example.exeSource}")

# When you are done, clean parsed variables
sbeClearJson(example)