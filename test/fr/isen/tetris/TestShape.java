package fr.isen.tetris;

import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.Test;

import fr.ubo.tetris.Shape;
import fr.ubo.tetris.Tetrominoes;

public class TestShape {

    private static Shape shape;

    @BeforeClass
    public static void setup() {
        shape = new Shape();
    }

    @Test
    public void testSetRandomShape() {
        // Vérifie que la forme initiale est NoShape
        Assert.assertEquals(Tetrominoes.NoShape, shape.getShape());

        // Modifie la forme
        shape.setRandomShape();

        // Vérifie que la forme n'est plus NoShape
        Assert.assertNotEquals(Tetrominoes.NoShape, shape.getShape());
    }
}
