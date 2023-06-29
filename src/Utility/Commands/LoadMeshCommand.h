#pragma once
#include "Command.h"
#include "Cala/Utility/Model.h"
#include "Coa/ECS/Components/MeshComponent.h"

class LoadMeshCommand : public Command {
public:
    LoadMeshCommand() = default;
    LoadMeshCommand(const Coa::Entity& entity) : Command(entity) {}
    LoadMeshCommand(const Coa::Entity& entity, const Cala::Model& model, 
        bool lightened = true, Coa::MeshComponent::Material material = Coa::MeshComponent::Material::Plastic) 
        : Command(entity), m_model(model), m_lightened(lightened), m_material(material) {}
    ~LoadMeshCommand() = default;
    void execute() override;

    Cala::Model m_model;
    bool m_lightened;
    Coa::MeshComponent::Material m_material;
};