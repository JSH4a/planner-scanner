import 'package:flutter/material.dart';

class Plan extends StatelessWidget {
  final String address;
  final String reference;
  final String status;
  final String dataReceived;
  final String proposal;

  Plan({
    super.key,
    required String address,
    required String reference,
    required String status,
    required String dataReceived,
    required String proposal,
  })
      : address = address.replaceAll('\r', ' '),
        reference = reference.replaceAll('\r', ' '),
        status = status.replaceAll('\r', ' '),
        dataReceived = dataReceived.replaceAll('\r', ' '),
        proposal = proposal.replaceAll('\r', ' ');

@override
Widget build(BuildContext context) {
  return Container(
    // Full width
    margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
    // Spacing around the card
    child: Card(
      elevation: 4.0, // Mild shadow for soft slook
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Padding inside the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address - Title styling
            Text(
              address,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              softWrap: true,
              overflow:
              TextOverflow.visible, // Allow overflowing to next line
            ),
            const SizedBox(height: 8.0),
            // Small spacing between title and meta data

            // Meta information (reference, status, dateReceived)
            Text(
              'Reference: $reference',
              style: const TextStyle(
                fontSize: 14.0,
              ),
              softWrap: true,
            ),
            Text(
              'Status: $status',
              style: const TextStyle(
                fontSize: 14.0,
              ),
              softWrap: true,
            ),
            Text(
              'Received: $dataReceived',
              style: const TextStyle(
                fontSize: 14.0,
              ),
              softWrap: true,
            ),
            const SizedBox(height: 12.0),
            // Spacing before the proposal text

            // Proposal - Regular readable text
            Text(
              proposal,
              style: const TextStyle(
                fontSize: 16.0,
                height: 1.5, // Line height for readability
              ),
              softWrap: true,
            ),
          ],
        ),
      ),
    ),
  );
}}