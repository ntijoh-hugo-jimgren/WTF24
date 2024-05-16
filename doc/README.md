# Projektets Namn

## Beskrivning

En applikation där användare kan skapa en lista med filmer de har sett. De kan betygsätta dessa och kommentera åsikter och tankar. Användare kan lägga till filmer i databasen som inte finns och filmer som lagts till av en användare kan sedan läggas till av andra i deras egna listor genom att söka upp befintliga titlar i databasen. 

## Användare och roller

Gästanvändare - oinloggad
. Kan söka efter titlar. 

Standardanvändare - inloggad. Kan allt gästanvändare kan, men kan även lägga in nya filmer och ta bort sin profil. 

Adminanvändare - kan ta bort/editera filmer och användare.

## ER-Diagram

![Er-Diagram](./er_diagram.png?raw=true "ER-diagram")

## Gränssnittsskisser

**Login**

![Er-Diagram](./ui_login.png?raw=true "ER-diagram")

**Visa bok**

![Er-Diagram](./ui_show_book.png?raw=true "ER-diagram")