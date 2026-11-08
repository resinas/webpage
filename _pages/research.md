---
layout: page
title: research
permalink: /research/
description: The main lines of research I work on, the problems behind them, and the tools and papers that came out of them.
nav: true
nav_order: 2
lines:
  - id: performance-measurement
    title: Process performance measurement
    teaser: How to define, compute and make sense of process performance indicators (PPIs), from notations and templates to natural language and LLMs.
  - id: process-of-process-mining
    title: The process of process mining and visual analytics
    teaser: How analysts actually carry out process mining, and visual and interactive tools that make their analyses easier.
  - id: productivity-collaboration
    title: Personal productivity and collaborative work
    teaser: Understanding how people organise their own work and collaborate with digital tools, using the data traces those tools leave behind.
  - id: ai-conversational-bpm
    title: AI and conversational agents in BPM
    teaser: Using chatbots and large language models to automate decisions, compute indicators and support people working with processes.
  - id: predictive-monitoring
    title: Predictive process monitoring
    teaser: Predicting how running process instances will turn out, and making sure those predictions are reliable and stay up to date.
  - id: compliance-management
    title: Compliance management
    teaser: Checking that business processes comply with regulations and policies, with flexible, low-code approaches.
---

<div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 research-cards">
  {% for line in page.lines %}
    <div class="col mb-4">
      <a href="#{{ line.id }}">
        <div class="card h-100 hoverable">
          <div class="card-body">
            <h2 class="card-title">{{ line.title }}</h2>
            <p class="card-text">{{ line.teaser }}</p>
          </div>
        </div>
      </a>
    </div>
  {% endfor %}
</div>

## Process performance measurement {#performance-measurement}

Organisations rely on process performance indicators (PPIs), such as the average time to handle a claim or the percentage of orders delivered on time, to know whether their processes meet their goals. Yet defining PPIs precisely, connecting them to the process models and data they refer to, and computing them reliably is far from trivial, and the people who need the indicators are rarely the ones who can implement them.

This has been a central line of my research for many years. With PPINOT we proposed a way of defining PPIs precisely enough to analyse them at design time and compute them automatically, together with a graphical notation (Visual PPINOT) and templates and linguistic patterns that let business people write PPIs in near-natural language. We have extended these ideas to knowledge-intensive processes, to variability across process variants, and to object-centric event data. More recently, we have explored how to go straight from textual descriptions of indicators to their computation over event logs, first with classic NLP techniques and now with large language models that can also suggest which indicators are worth computing.

**Tools:** [PPINOT](https://github.com/isa-group/ppinot) · [ppinot4py](https://github.com/isa-group/ppinot4py) · [PPINaT](https://github.com/isa-group/ppinat)

**Key publications**

<div class="publications">
{% bibliography --query @*[key=DBLP:journals/is/del-Rio-OrtegaRCC13 || key=DBLP:journals/eis/del-Rio-OrtegaR16 || key=DBLP:journals/bise/del-Rio-OrtegaR19 || key=DBLP:journals/toit/Estrada-TorresR19 || key=DBLP:journals/access/Estrada-Torresd21 || key=DBLP:conf/bpm/Estrada-Torresd22 || key=DBLP:conf/bpm/ResinasdA23 || key=DBLP:journals/is/AgostinellidEGMRR26] --group_by none %}
</div>

<p class="text-right"><a href="#">↑ back to overview</a></p>

## The process of process mining and visual analytics {#process-of-process-mining}

Process mining techniques are only as useful as the analyses people carry out with them. Analysts start from business questions, explore event data through process maps and other views, compare variants, and turn what they find into reports and recommendations. This "process of process mining" is still poorly understood, and the tools analysts use offer limited support for it.

Rather than proposing new discovery or conformance checking algorithms, this line studies how analysts actually work and builds tools around their needs. We have analysed how process mining reports answer performance questions and compiled a taxonomy and catalog of the questions analysts can ask. On the tool side, we focus on visual analytics: LoVizQL, a query language to build visualisations from event logs; interfaces to explore and compare large collections of directly-follows graphs and process models; visualisations of event sequences that overcome the limitations of directly-follows graphs; and Tiramisù, which combines several perspectives of process information (time, space and others) in a single visual sensemaking environment. Our most recent work explains process variants through natural examples and captures the provenance of process mining analyses.

**Key publications**

<div class="publications">
{% bibliography --query @*[key=DBLP:conf/bpm/Capitan-AgudoSC22 || key=DBLP:journals/bise/ZimmermannZGRW26 || key=DBLP:conf/icsoc/SalasUrbanoCCR23 || key=DBLP:journals/jiis/AlmanABBCR26 || key=DBLP:conf/bpmds/Salas-UrbanoCCR24 || key=DBLP:conf/bpm/MontanaRV25 || key=DBLP:journals/sosym/SalasUrbanoCCR26 || key=DBLP:conf/bpm/CapitanAgudoCCR26 || key=DBLP:conf/er/BernalCaunedoFVRW26] --group_by none %}
</div>

<p class="text-right"><a href="#">↑ back to overview</a></p>

## Personal productivity and collaborative work {#productivity-collaboration}

A large part of today's knowledge work does not follow a predefined process: people juggle tasks across email, chats, calendars and collaborative tools such as Kanban-style boards. Digital transformation has multiplied these tools, but it has also created new productivity challenges for individuals and teams.

In this line we apply ideas from BPM and process mining to this kind of work. We have identified design patterns for board-based collaborative work management tools, and patterns for how processes are created and terminated when they are managed with boards, and we analyse how boards are used and how they evolve with Board Miner. At the personal level, we use activity data, such as active window tracking, to help people understand how they spend their time: Work Tagger supports labelling this data, and Tiramisù offers a calendar-like view of it. We also study collaboration itself, from interruptibility in scientific research collaborations to how distributed cooperative work can be understood through the data traces it leaves.

**Tools:** [Work Tagger](https://github.com/project-pivot/worktagger) · [Tiramisù calendar](https://github.com/tiramisuframework/tiramisu-calendar) · [Board Mining](https://github.com/isa-group/board-mining)

**Key publications**

<div class="publications">
{% bibliography --query @*[key=DBLP:conf/hicss/del-Rio-OrtegaP21 || key=DBLP:conf/bpm/PenaBR22 || key=DBLP:conf/caise/PenaBdRR21 || key=DBLP:conf/icsoc/BravoCPR22 || key=DBLP:conf/coopis/BravodPR25 || key=DBLP:conf/icpm/ResinasGBdR24 || key=DBLP:conf/cscw/BeerepootdRR24 || key=DBLP:conf/ecscw/BeerepootRdRB25] --group_by none %}
</div>

<p class="text-right"><a href="#">↑ back to overview</a></p>

## AI and conversational agents in BPM {#ai-conversational-bpm}

Conversational interfaces and large language models open new ways for people to interact with processes: asking questions in natural language, getting decisions explained, or delegating tedious analysis tasks. The challenge is to use them in a way that is grounded in the models and data organisations already have.

We started this line with DemaBot, which automatically generates decision-support chatbots from DMN decision models, so that decisions captured in models can be made through a dialog. Since then we have mapped the landscape of large language model applications in BPM and used LLMs to bridge natural language and process analysis, for instance to compute process performance indicators described in plain text (see [performance measurement](#performance-measurement)). We are also exploring LLMs in BPM education, such as simulated domain experts that help students practise interviews for business process modelling.

**Tools:** [PPINaT](https://github.com/isa-group/ppinat)

**Key publications**

<div class="publications">
{% bibliography --query @*[key=DBLP:conf/bpm/Estrada-Torresd21 || key=DBLP:journals/corr/abs-2109-00822 || key=DBLP:journals/corr/abs-2405-09645 || key=DBLP:conf/bpmds/Estrada-Torresd24 || key=DBLP:conf/bpm/ResinasdA23 || key=DBLP:journals/is/AgostinellidEGMRR26] --group_by none %}
</div>

<p class="text-right"><a href="#">↑ back to overview</a></p>

## Predictive process monitoring {#predictive-monitoring}

Predictive process monitoring uses historical event data to predict how running process instances will unfold, for example whether a case will be late or whether an indicator will miss its target, so that people can act before problems happen.

We surveyed the field and have worked on predicting process performance indicators at run time, from evolutionary decision rules to context-aware predictions. A recurring concern in our work is whether predictions can be trusted: we have proposed ways to assess the reliability of individual predictions, studied how to keep prediction models up to date as processes change, and recently explored causally-informed predictive monitoring.

**Key publications**

<div class="publications">
{% bibliography --query @*[key=DBLP:journals/tsc/Marquez-Chamorro18 || key=DBLP:conf/icsoc/ComuzziCR18 || key=DBLP:conf/sac/ComuzziCR19 || key=DBLP:journals/eswa/ChamorroRCT17 || key=DBLP:journals/access/ChamorroRRdSR20 || key=DBLP:conf/caise/ChamorroNRR22 || key=DBLP:conf/icsoc/ChamorroRRR24] --group_by none %}
</div>

<p class="text-right"><a href="#">↑ back to overview</a></p>

## Compliance management {#compliance-management}

Organisations must make sure that their business processes comply with laws, regulations and internal policies. Compliance requirements are diverse, change over time and are often owned by people who are not IT specialists, which makes them hard to check with a single, rigid technique.

Our approach combines different compliance checking techniques in a flexible way. We first explored the features a full-coverage compliance solution should have and proposed a mashup-based approach, in which several checking components are composed to verify a process, later developed into a complete framework for business process compliance checking. Building on these ideas, STATUS is a low-code business process compliance management system that lets organisations define and monitor compliance requirements without heavy programming.

**Tools:** [STATUS infrastructure](https://github.com/statuscompliance/infrastructure)

**Key publications**

<div class="publications">
{% bibliography --query @*[key=DBLP:conf/bpm/BernalMC0R24 || key=DBLP:journals/tsc/CabanillasRR22 || key=DBLP:conf/caise/CabanillasRC12 || key=DBLP:conf/caise/CabanillasRC11] --group_by none %}
</div>

<p class="text-right"><a href="#">↑ back to overview</a></p>
