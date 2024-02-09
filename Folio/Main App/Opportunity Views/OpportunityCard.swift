//
//  OpportunityView.swift
//  Folio
//
//  Created by Hailey Pan on 2/1/24.
//
import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestoreSwift
import FirebaseFirestore

struct OpportunityCard: View {
    var opportunity: Opportunity
    @State private var isSaved = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.gray)
                Text(opportunity.organization)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .truncationMode(.tail)
                Spacer()
                Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                                    .foregroundColor(.customTurquoise)
                                    .font(.title)
                                    .onTapGesture {
                                        saveOpportunity(opportunity)
                                    }
            }
            Text(opportunity.title)
                .font(.headline)
                .foregroundColor(.customGray)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .truncationMode(.tail)
                .frame(minHeight: 44)
            HStack(spacing: 5) { // Wrap the location text and icon in an HStack
                Image(systemName: "mappin")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12) // Adjust size as needed
                    .foregroundColor(.secondary)
                Text(opportunity.location)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            BadgeView(text: opportunity.type, color: colorForType(opportunity.type))
            
            if let level = opportunity.level, !level.isEmpty {
                BadgeView(text: level, color: colorForLevel(level))
            }

            if let programDates = opportunity.programDates, !programDates.isEmpty {
                Text("Program Dates: \(programDates)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Text("Apply by \(opportunity.applicationDeadline ?? "N/A")")
                .font(.caption)
                .foregroundColor(.secondary)
            
            if let registrationDeadline = opportunity.registrationDeadline, !registrationDeadline.isEmpty {
                Text("Registration Deadline: \(registrationDeadline)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

        }
        .padding()
        .background(Color.gray.opacity(0.15))
        .cornerRadius(10)
        .clipped()
        .frame(width: UIScreen.main.bounds.width - 150, height: 250) // Set a fixed width and height
        
    }
    
    // Function to determine the color for the type badge
    func colorForType(_ type: String) -> Color {
        switch type {
        case "Internship":
            return .green
        case "Competition":
            return .orange
        case "Volunteering":
            return .red
        case "Scholarship":
            return .yellow
        default:
            return .gray
        }
    }

    // Function to determine the color for the level badge
    func colorForLevel(_ level: String) -> Color {
        switch level {
        case "Beginner":
            return .blue
        case "Intermediate":
            return .purple
        case "Advanced":
            return .pink
        default:
            return .gray
        }
    }
    
    func saveOpportunity(_ opportunity: Opportunity) {
            guard let userId = Auth.auth().currentUser?.uid else { return }

            let db = Firestore.firestore()
            let userOpportunityRef = db.collection("Users").document(userId).collection("SavedOpportunities")
            guard let opportunityId = opportunity.id else {
                    print("Error: Opportunity ID is nil")
                    return
                }
            
            // Check if the opportunity is already saved
            userOpportunityRef.whereField("opportunityId", isEqualTo: opportunity.id).getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else if snapshot!.isEmpty {
                    // Opportunity not saved yet, proceed to save
                    userOpportunityRef.addDocument(data: [
                        "opportunityId": opportunity.id,
                        // Add other opportunity details as needed
                    ]) { error in
                        if let error = error {
                            print("Error saving document: \(error)")
                        } else {
                            print("Opportunity successfully saved!")
                            // Update the isSaved state to true
                            self.isSaved = true
                        }
                    }
                } else {
                    print("Opportunity already saved.")
                    // If the opportunity is already saved, ensure the bookmark shows as filled
                    self.isSaved = true
                }
            }
        }
}

struct BadgeView: View {
    let text: String
    let color: Color
    
    var body: some View {
        Text(text)
            .font(.caption)
            .padding(5)
            .background(color)
            .foregroundColor(.customGray)
            .cornerRadius(5)
    }
}
