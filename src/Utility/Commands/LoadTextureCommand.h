#pragma once
#include "Command.h"
#include "Cala/Utility/Image.h"

class LoadTextureCommand : public Command {
public:
    enum class Map {
        Diffuse, Specular, Normal
    };

public:
    LoadTextureCommand(const Coa::Entity& entity, Map map, bool remove = false) : Command(entity), m_map(map), m_remove(remove) {}
    ~LoadTextureCommand() = default;
    void execute() override;

    Cala::Image m_image;

private:
    Map m_map;
    bool m_remove;
};