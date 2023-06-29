#pragma once
#include "Command.h"
#include "Coa/Utility/SharedLibrary.h"

class LoadScriptCommand : public Command {
public:
    LoadScriptCommand(const Coa::Entity& entity, const Coa::SharedLibrary& _sharedLibrary, const std::string& _className);
    ~LoadScriptCommand() = default;
    void execute() override;

private:
    Coa::SharedLibrary sharedLibrary;
    std::string className;
};