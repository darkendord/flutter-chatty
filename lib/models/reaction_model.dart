import 'package:flutter/cupertino.dart';

enum Reaction { like, laugh, love, none }

class ReactionModel {
  final int id;
  final int reactionTypeId;
  final int referenceTypeId;
  final String referenceType;
  final bool active;
  final int createdBy;
  final Reaction reaction;
  final Icon icon;

  const ReactionModel(
    this.id,
    this.reactionTypeId,
    this.referenceType,
    this.referenceTypeId,
    this.active,
    this.createdBy,
    this.reaction,
    this.icon,
  );

  factory ReactionModel.fromJson(Map<String, dynamic> json) {
    return ReactionModel(
      json['id'],
      json['reaction_type_id'],
      json['reference_type'],
      json['reference_type_id'],
      json['active'],
      json['created_by'],
      json['reaction'],
      json['icon'],
    );
  }
}
