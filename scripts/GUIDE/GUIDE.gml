/*
-------------------------------------------------------------------------------------------------------------------------------------------------------------

    Thank you for purchasing Interactive Books. Here's some information on how to use the asset.

-------------------------------------------------------------------------------------------------------------------------------------------------------------

    The resources:
    
    If you've imported all the resources from the asset into your project you'll see that they're organized into two types of folders, one called
    "Interactive Books" and the other called "Example". "Interactive Books" contains the essential resources needed to use the Interactive Books asset.
    "Example" contains resources used in the example that shows up when you run the game. Resources in the "Example" folders are well commented and
    shows you how you can use the Interactive Books asset.
    
    To use Interactive Books all you have to do is to call scripts from the "Interactive Books" folder. All of the scripts are commented with a general
    description of what the script does as well as descriptions specific to each parameter. It's recommended that you read through these whenever
    you want to use them.
    
-------------------------------------------------------------------------------------------------------------------------------------------------------------

    Implementing Interactive Books into your game - the essential steps:
    
    First off you'll have to create a book with ib_book_create. This script returns an instance id that you will use with the other scripts in the
    asset later. You can then add sheets to the book with ib_book_add_sheet. In the create event of obj_example_main you can see how ib_book_add_sheet
    is used to add all the sheets of the example book.
    
    Then you should find a draw event to call ib_book_draw in. This will draw your book to the screen.
    
    You can use ib_book_goto_sheet to move to different pages in the book.

-------------------------------------------------------------------------------------------------------------------------------------------------------------

    Further implementation of Interactive Books into your game:
    
    ib_book_set_transformation: This script lets you set the position and scale of the book.
    
    ib_sheet_position_curved_to_flat/ib_sheet_position_flat_to_curved: These scripts let you transform positions between the flat version of a sheet
    and the version where the sheet is curved out. This can be used if you e.g. want to check presses on a rectangular button that is curved out when
    drawn. The curve makes it impossible to check collision with the button like normal, so you have to transform the position from curved to flat first.
    The example code shows how this can be done in obj_example_button.
    
    If you want to add your own custom pages to the book containing e.g. various pieces of text (stored in strings) and sprites, you should use
    surfaces. The book needs all the pages' graphics to be provided as textures to easily apply the book's animation to them. The example code uses
    surfaces for several of the sheets in the example book; the sheets filled with text, the sheet with the two buttons, and the text input field
    sheet. If you don't know anything about surfaces, they're worth looking into before continuing to read. All surfaces used in the example code
    have variables starting with "sf_". All these variables are set to -1 in obj_example_main's create event and their respective sheets have their
    textures set to -1. The surfaces are set to -1 because surfaces are volatile. Setting them directly to surface_create() and leaving it at that is
    risky as surfaces can suddenly cease to exist. So instead we check if the surface exists with surface_exists() in the script "example_set_surfaces"
    which is called in the draw event. If it doesn't exist, we make sure to create it so that the book can display it afterward. This is what
    example_set_surfaces does. The reason we set the surfaces to -1 in the create event is so that they will automatically be created in
    example_set_surfaces (because surface_exists(-1) returns false) which saves us from having duplicate code. The reason the respective sheets' textures
    are set to -1 is because we have to wait for the surfaces to exist before we can give the sheets their proper textures. After we have created the
    surfaces in example_set_surfaces, we use ib_sheet_set_texture and assigns every sheet with their respective surface (using surface_get_texture() to
    get the surface's texture). If your book has hundreds of pages that need surfaces, creating surfaces for every single one of them can be very
    expensive in terms of memory. In this case you can for example set every sheet in the book to a default page (for example a blank page)
    and then draw the page content that's actually there to a surface whenever the sheet becomes visible in the book. This surface can then be
    assigned to the respective sheet with ib_sheet_set_texture as explained earlier in this paragraph. The script called ib_sheet_is_visible can be used
    to check if a sheet is visible.
        
    If you want to know more, there are lots of comments with explanations in the example code and the scripts themselves. You can also contact me
    by sending a mail to mytinogames@gmail.com or messaging Dragon47 on the GameMaker Community.

-------------------------------------------------------------------------------------------------------------------------------------------------------------
*/
