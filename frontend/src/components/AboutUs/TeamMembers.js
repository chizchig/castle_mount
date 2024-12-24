// src/components/AboutUs/TeamMembers.js
import React, { useEffect, useState } from 'react';
import axios from 'axios';

const TeamMembers = () => {
  const [members, setMembers] = useState([]);

  useEffect(() => {
    axios.get('/api/team-members')
      .then(response => setMembers(response.data))
      .catch(error => console.error('Error fetching team members:', error));
  }, []);

  return (
    <section>
      <h2>Our Team</h2>
      <ul>
        {members.map(member => (
          <li key={member.id}>{member.name} - {member.role}</li>
        ))}
      </ul>
    </section>
  );
};

export default TeamMembers;
