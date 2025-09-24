//
//  ContentView.swift
//  lab1
//
//  Created by Alejandro Avina and Hasan Dababo on 9/15/25.
//

import SwiftUI

private let dogNames: [String] = [
    "Airedale Terrier","American Foxhound","Dutch Shepherd","Havanese","Leonberger",
    "Mudi","Norwegian Lundehund","Pharaoh Hound","Scottish Terrier","Tosa"
]

private let dogDescriptions: [String] = [
    "The Airedale stands among the world's most versatile dog breeds and has distinguished himself as hunter, athlete, and companion.",
    "American Foxhounds are good-natured, low-maintenance hounds who get on well with kids, dogs, even cats, but come with special considerations for prospective owners.",
    "The Dutch Shepherd is a lively, athletic, alert and intelligent breed, and has retained its herding instinct for which it was originally developed.",
    "Havanese, the only dog breed native to Cuba, are vivacious and sociable companions and are especially popular with American city dwellers.",
    "The Leonberger is a lush-coated giant of German origin. They have a gentle nature and serene patience and they relish the companionship of the whole family.",
    "The Mudi is an extremely versatile, intelligent, alert, agile, all-purpose Hungarian farm dog. The breed is a loyal protector of property and family members without being overly aggressive.",
    "From Norway’s rocky island of Vaeroy, the uniquely constructed Norwegian Lundehund is the only dog breed created for the job of puffin hunting. With puffins now a protected species, today’s Lundehund is a friendly, athletic companion.",
    "The Pharaoh Hound, ancient \"Blushing Dog\" of Malta, is an elegant but rugged sprinting hound bred to course small game over punishing terrain. Quick and tenacious on scent, these friendly, affectionate hounds settle down nicely at home.",
    "A solidly compact dog of vivid personality, the Scottish Terrier is an independent, confident companion of high spirits. Scotties have a dignified, almost-human character.",
    "The Tosa's temperament is marked by patience, composure, boldness and courage. He is normally a tranquil, quiet, and obedient dog, with a calm but vigilant demeanor."
]

private let dogDict: [String: String] = Dictionary(uniqueKeysWithValues: zip(dogNames, dogDescriptions))

struct ContentView: View {
    @State private var selectedDog: String? = nil

    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)

    var body: some View {
        VStack(spacing: 16) {

            Text("Tap a dog to see its description")
                .font(.headline)
                .padding(.top)

            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(dogNames, id: \.self) { name in
                        DogTile(name: name, isSelected: selectedDog == name)
                            .onTapGesture {
                                selectedDog = name
                            }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 4)
            }

            Group {
                if let selectedDog, let desc = dogDict[selectedDog] {
                    VStack(spacing: 8) {
                        Text(selectedDog)
                            .font(.title3)
                            .fontWeight(.semibold)

                        Text(desc)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color(.secondarySystemBackground))
                    )
                    .padding(.horizontal)
                } else {
                    Text("No dog selected yet. Pick one above!")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(.bottom)
                }
            }

            Spacer(minLength: 8)
        }
    }
}

private struct DogTile: View {
    let name: String
    let isSelected: Bool

    var body: some View {
        Image(name)
            .resizable()
            .scaledToFit()
            .frame(height: 90)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.accentColor : Color.clear, lineWidth: 3)
            )
            .shadow(radius: 2, x: 0, y: 1)
            .accessibilityLabel(Text(name))
            .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

#Preview {
    ContentView()
}
