# amazon-list

This repository currently contains one Perl module, Amazon::List, and a
small Perl program which uses the aformentioned module to obtain information
from items on an Amazon list and print those formatted.

Example call:

~~~
perl listitems.pl https://www.amazon.com/gp/registry/wishlist/ORJQ2XBS0VCK/
~~~

Example output:

~~~
  1.  The Thrilling Adventures of Lovelace and Babbage: The            19.68
      (Mostly) True Story of the First Computer (Pantheon Graphic
      Novels) by Sydney Padua (Hardcover)
  2.  The Hidden Life of Trees: What They Feel, How They               13.57
      CommunicateDi​scoveries from a Secret World by Peter
      Wohlleben, Tim Flannery (Hardcover)
  3.  Venomous: How Earth's Deadliest Creatures Mastered               16.91
      Biochemistry by Christie Wilcox (Hardcover)
  4.  Women in Science: 50 Fearless Pioneers Who Changed the World      9.24
      by Rachel Ignotofsky (Hardcover)
  5.  The Confidence Game: Why We Fall for It . . . Every Time by      25.56
      Maria Konnikova (Hardcover)
  6.  Thing Explainer: Complicated Stuff in Simple Words by            13.99
      Randall Munroe (Hardcover)
  7.  An Illustrated Book of Bad Arguments by Ali Almossawi,            6.99
      Alejandro Giraldo (Hardcover)

                                                         Total price: 105.94
~~~
