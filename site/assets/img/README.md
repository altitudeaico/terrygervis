# Image drop-in guide

Every dashed box on the site names the exact file it expects. Save the image
under that name in this folder and add one <img> line inside the matching
<figure class="slot"> — the CSS does the cropping (object-fit: cover).

Example, in about.html:

    <figure class="slot slot--tall" style="margin:0;">
      <img src="assets/img/terry-portrait.jpg" alt="Terry Jervis">
      <figcaption class="slot__hint">...</figcaption>
    </figure>

Once the img is in, the hint sits behind it and can be deleted.

## Expected files

| File | Page | Content |
|---|---|---|
| terry-portrait.jpg | about | Terry portrait |
| award-no10.jpg | about | Number 10 presentation |
| award-lcci.jpg | about | LCCI Black Excellence award |
| award-npg.jpg | about | National Portrait Gallery |
| award-bfi.jpg | about | BFI salute event |
| award-windrush.jpg | about | House of Lords signing |
| award-stem.jpg | about | STEM Women in Defence award |
| case-starrship.jpg | work | StaRRship visual |
| case-collection.jpg | work | Collection composition (exists: progress site assets) |
| case-millennium.jpg | work | Millennium broadcast still |
| case-pharaoh.jpg | work | Spirit of the Pharaoh art |
| case-raf.jpg | work | RAF-related imagery |
| coins-box-open.jpg | coins | Open box hero (exists: progress site assets/box-open.jpg) |
| coin-windrush.jpg | coins | Windrush coin |
| coin-tuskegee.jpg | coins | Tuskegee coin |

Aim for ~1400px on the long edge, JPG quality ~84.

Two are already in this repo at the root: ../../assets/box-open.jpg and
../../assets/collection.jpg — copy them in under the new names.
