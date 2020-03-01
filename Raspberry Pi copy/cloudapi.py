try:
    from google.cloud import vision
except:
    0 == 0

def localize_objects(path):
    """Localize objects in the local image.

    Args:
    path: The path to the local file.
    """
    client = vision.ImageAnnotatorClient()

    with open(path, 'rb') as image_file:
        content = image_file.read()
    image = vision.types.Image(content=content)

    objects = client.object_localization(
        image=image).localized_object_annotations

    for object_ in objects:
        if object_.name == "recycle" or object_.name == "bottle" or object_.name == "plastic":
            return "recycle"
        else:
            return "trash"