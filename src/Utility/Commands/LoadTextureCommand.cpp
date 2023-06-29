#include "LoadTextureCommand.h"
#include "Coa/ECS/Components/TextureComponent.h"

void LoadTextureCommand::execute()
{
    Coa::TextureComponent& texComp = m_entity.getComponent<Coa::TextureComponent>();
    switch (m_map)
    {
        case Map::Diffuse:
            m_image.getData() == nullptr ? texComp.diffuseMap.free() : texComp.diffuseMap.load2DTextureFromImage(m_image);
            break;
        case Map::Specular:
            m_image.getData() == nullptr ? texComp.specularMap.free() : texComp.specularMap.load2DTextureFromImage(m_image);
            break;
        case Map::Normal:
            m_image.getData() == nullptr ? texComp.normalMap.free() : texComp.normalMap.load2DTextureFromImage(m_image);
            break;
    }
}