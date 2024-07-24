import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/actors/player.dart';
import 'package:flutter_game/levels/level.dart';

class PixelAdventure extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks {
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  late final CameraComponent cam;
  Player player = Player(character: 'Mask Dude');
  late JoystickComponent joyStick;
  @override
  FutureOr<void> onLoad() async {
    // Load all images into cache
    await images.loadAllImages();

    final world = Level(
      levelName: 'Level-01',
      player: player,
    );
    cam = CameraComponent.withFixedResolution(
      world: world,
      width: 640,
      height: 360,
    )
      ..priority = 0
      ..viewfinder.anchor = Anchor.bottomLeft;
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([cam, world]);

    addJoyStick();

    return super.onLoad();
  }

  void addJoyStick() {
    joyStick = JoystickComponent(
      priority: 1,
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Knob.png'),
        ),
      ),
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Joystick.png'),
        ),
      ),
      margin: const EdgeInsets.only(left: 32, bottom: 32),
    );
    add(joyStick);
  }
}
