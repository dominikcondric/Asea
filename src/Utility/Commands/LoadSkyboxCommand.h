#pragma once
#include "Command.h"
#include "Coa/ECS/Components/SkyboxComponent.h"
#include "Cala/Utility/Image.h"
#include <array>

class LoadSkyboxCommand : public Command {
public:
    LoadSkyboxCommand(const Coa::Entity& entity, bool singleTexture = false) : Command(entity), m_singleTexture(singleTexture) {}
    ~LoadSkyboxCommand() = default;
    void execute() override;

    std::array<Cala::Image, 6> m_images;
    bool m_singleTexture;
};