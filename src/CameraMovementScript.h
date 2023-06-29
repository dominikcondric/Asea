#pragma once
#include "Coa/ECS/Components/ScriptComponent.h"
#include "Coa/ECS/Scene.h"

#define CLASS_NAME CameraMovementScript
#define CONCAT(A, B) A ## B
#define EXPAND(A, B) CONCAT(A, B)
#define LOAD_FUNCTION EXPAND(load, CLASS_NAME) 

class COA_DLL CLASS_NAME : public Coa::ScriptComponent::Script {
public:
    CLASS_NAME() = default;
    ~CLASS_NAME() = default;
    void execute(Coa::Entity entity, const Cala::IIOSystem& io, float deltaTime) override;
    void loadNewEntities(Coa::Scene& scene) override;
};

extern "C" COA_DLL Coa::ScriptComponent::Script* LOAD_FUNCTION()
{
    return new CLASS_NAME;
}