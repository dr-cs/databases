graph pet_shelter {
      include(pet-shelter-entity.dot)
      include(worker-entity.dot)
      include(pet-entity.dot)

      node [shape=diamond]; WORKS_FOR;
      WORKS_FOR -- PET_SHELTER [label="1", color="black:invis:black"];
      WORKER -- WORKS_FOR [label="N", color="black:invis:black"];


      node [shape=diamond, peripheries=2]; HOUSED_AT;
      PET_SHELTER -- HOUSED_AT [label="1"];
      HOUSED_AT -- PET [label="N", color="black:invis:black"];
}
