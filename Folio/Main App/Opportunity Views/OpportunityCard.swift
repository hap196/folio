//
//  OpportunityView.swift
//  Folio
//
//  Created by Hailey Pan on 2/1/24.
//
import SwiftUI

struct OpportunityCard: View {
    var opportunity: Opportunity

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
                Image(systemName: "bookmark")
                    .foregroundColor(.customTurquoise)
                    .font(.title) // Make the bookmark icon larger
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
