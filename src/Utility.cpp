#include "Utility.h"
#include <fstream>
#include <filesystem>
#include <iostream>

static const char* ScriptCode = 
R"(#pragma once
#include "Coa/ECS/Components/ScriptComponent.h"
#include "Coa/ECS/Scene.h"

#define CLASS_NAME ClassName
#define CONCAT(A, B) A ## B
#define EXPAND(A, B) CONCAT(A, B)
#define LOAD_FUNCTION EXPAND(load, CLASS_NAME) 

class COA_DLL CLASS_NAME : public Coa::ScriptComponent::Script {
public:
    CLASS_NAME() = default;
    ~CLASS_NAME() = default;
    void execute(Coa::Entity entity, const Cala::IIOSystem& io, float deltaTime) override;
    // void loadNewEntities(Coa::Scene& scene) override;  // Optional
};

extern "C" COA_DLL Coa::ScriptComponent::Script* LOAD_FUNCTION()
{
    return new CLASS_NAME;
})";

static const char* CMakeProjectCode = 
R"(cmake_minimum_required(VERSION 3.16 FATAL_ERROR)

set(LibraryName LibName)

project(${LibraryName} LANGUAGES CXX)

option(COA_BUILD_DEMO OFF)

add_subdirectory(Coa)

add_library(${LibraryName}
    SHARED
        # Files
)

target_link_libraries(${LibraryName}
    PRIVATE
        Coa
)

target_compile_definitions(${LibraryName}
    PRIVATE
        COA_BUILD_DLL
)

)";

void Utility::generateScript(const QString &directoryPath, const QString& className)
{
    std::string codeString(ScriptCode);
    codeString.replace(108, 11, className.toStdString());

    std::string fileName = directoryPath.toStdString() + "/" + className.toStdString() + ".h";
    std::ofstream outputFile(fileName);
    outputFile.write(codeString.c_str(), codeString.size());
    outputFile.close();
}

void Utility::createNewProject(const QString &directoryPath, const QString& projectName)
{
    namespace fs = std::filesystem;

    fs::path coaPath(std::string(__FILE__));
    coaPath = coaPath.parent_path().parent_path() / "Dependencies/Coa";
    fs::path targetPath(directoryPath.toStdString() + "/" + projectName.toStdString());
    fs::create_directory(targetPath);
    fs::path coaTargetPath(targetPath / "Coa");
    fs::create_directory(coaTargetPath);

    for (const auto& entry : fs::directory_iterator(coaPath))
        if (entry != coaPath / ".git")
            fs::copy(entry, coaTargetPath / entry.path().filename(), fs::copy_options::recursive);

    fs::remove(coaTargetPath / "Dependencies/Cala/.git");

    std::string cmakeListsString(CMakeProjectCode);
    cmakeListsString.replace(66, 7, projectName.toStdString());
    std::string fileName = (targetPath / "CMakeLists.txt").string();
    std::ofstream outputFile(fileName);
    outputFile.write(cmakeListsString.c_str(), cmakeListsString.size());
    outputFile.close();
}