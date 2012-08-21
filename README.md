# Backlogjp

Backlogjp is a ruby API wrapper for http://www.backlog.jp

## Installation

    $ gem install backlogjp

## Usage

    # Obtain the API client
    Backlogjp.new("space-name", "username", "password")

    # Retrieve all projects
    Backlogjp::Project.all
    # >> [ Project, Project, ... ]
    #
    # Retrieve individual project by key
    project = Backlogjp::Project.find_by_key "PROJECT-1"
    # >> Project
    # List users assigned to the project
    project.users
    # >> [ User, User, User, ... ]
    # List versions and milestones defined for the project
    project.versions
    # >> [ Version, Version ... ]

## License

Backlogjp is released under the MIT license. For more information, see `LICENSE`
