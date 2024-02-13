//
//  OpportunityDetailsView.swift
//  Folio
//
//  Created by Hailey Pan on 1/31/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct OpportunityDetailsView: View {
    var opportunity: Opportunity
    
    @State private var showingSafariView = false
    @State private var isSaved = false
    
    private var applyLink: URL? {
        URL(string: opportunity.link)
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text(opportunity.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.customGray)
                    
                    HStack {
//                        Image("placeholder")
//                            .resizable()
//                            .frame(width: 50, height: 50)
//                            .cornerRadius(8)

                        VStack(alignment: .leading) {

                            HStack {
                                Image(systemName: "location.fill")
                                Text(opportunity.location)
                                    .font(.subheadline)
                                    .foregroundColor(.customGray)
                            }

                            // Tags for type and level
                            HStack {
                                Text(opportunity.type)
                                    .font(.caption)
                                    .padding(5)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(5)
                                
                                Text(opportunity.level ?? "Unknown")
                                    .font(.caption)
                                    .padding(5)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(5)
                            }
                        }
                    }

                    Divider()

                    Text("About this Opportunity")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.vertical, 5)
                        .foregroundColor(.customGray)

                    Text(opportunity.description)
                        .font(.body)
                        .foregroundColor(.gray)

//                    Text("Eligibility")
//                        .font(.headline)
//                        .fontWeight(.bold)
//                        .padding(.vertical, 5)
//                        .foregroundColor(.customGray)
//
//                    ForEach(opportunity.eligibility?.components(separatedBy: ",") ?? [], id: \.self) { qualification in
//                        Text("• \(qualification.trimmingCharacters(in: .whitespacesAndNewlines))")
//                    }
//                    .foregroundColor(.gray)
                    
                    Spacer()
                }
                .padding()
            }

            VStack {
                Spacer()

                Divider()

                HStack {
                    Button(action: {
                                self.showingSafariView = true
                            }) {
                                Text("Apply Now")
                                    .frame(maxWidth: .infinity, minHeight: 50)
                                    .background(Color.customTurquoise)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .padding()
                            .sheet(isPresented: $showingSafariView) {
                                if let applyLink = applyLink {
                                    SafariView(url: applyLink)
                                }
                            }

                    Button(action: {
                                        saveOpportunity(opportunity)
                                    }) {
                                        Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                                            .padding()
                                            .background(Color.gray.opacity(0.2))
                                            .cornerRadius(8)
                                            .foregroundColor(.customTurquoise)
                                    }
                                    .padding(.trailing)
                }
            }
            .onAppear {
                        checkIfOpportunityIsSaved(opportunity)
                    }
        }
        .navigationBarTitle(Text("Venture Details"), displayMode: .inline)
        .edgesIgnoringSafeArea(.bottom)
        
    }
    private func checkIfOpportunityIsSaved(_ opportunity: Opportunity) {
            guard let userId = Auth.auth().currentUser?.uid, let opportunityId = opportunity.id else { return }
            let db = Firestore.firestore()
            let userOpportunityRef = db.collection("Users").document(userId).collection("SavedOpportunities")
            
            userOpportunityRef.whereField("opportunityId", isEqualTo: opportunityId).getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    self.isSaved = !snapshot!.isEmpty
                }
            }
        }
        
        private func saveOpportunity(_ opportunity: Opportunity) {
            guard let userId = Auth.auth().currentUser?.uid, let opportunityId = opportunity.id else { return }
            let db = Firestore.firestore()
            let userOpportunityRef = db.collection("Users").document(userId).collection("SavedOpportunities")

            if isSaved {
                
                userOpportunityRef.whereField("opportunityId", isEqualTo: opportunityId).getDocuments { (querySnapshot, err) in
                    if let err = err {
                        print("Error removing saved opportunity: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            document.reference.delete() { err in
                                if let err = err {
                                    print("Error removing saved opportunity: \(err)")
                                } else {
                                    print("Opportunity successfully unsaved")
                                    self.isSaved = false
                                }
                            }
                        }
                    }
                }
            } else {
                userOpportunityRef.addDocument(data: [
                    "opportunityId": opportunityId
                ]) { error in
                    if let error = error {
                        print("Error saving document: \(error)")
                    } else {
                        print("Opportunity successfully saved!")
                        self.isSaved = true
                    }
                }
            }
        }
}

