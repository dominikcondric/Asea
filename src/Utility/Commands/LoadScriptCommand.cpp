#include "LoadScriptCommand.h"
#include "Coa/ECS/Components/ScriptComponent.h"

LoadScriptCommand::LoadScriptCommand(const Coa::Entity& entity, const Coa::SharedLibrary &_sharedLibrary, const std::string &_className)
    : Command(entity), sharedLibrary(_sharedLibrary), className(_className)
{
}

void LoadScriptCommand::execute()
{
    m_entity.getComponent<Coa::ScriptComponent>().loadScript(sharedLibrary, className);
}
