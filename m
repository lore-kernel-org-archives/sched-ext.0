Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012024.outbound.protection.outlook.com [52.101.43.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694B42D5C7A
	for <sched-ext@lists.linux.dev>; Sat,  6 Dec 2025 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765049432; cv=fail; b=r80WdgCC+iFahrpbqW2HfP0eGYdptmvCehHgQPgkUXF974Pkptyx7OL6LI3cT0c8lntS/alI23QsuVYz8iyFXrWoHULI59ud+C/kTLFewMLo+dti9pswOxDFjw9LCqeEOpqEjg6tgM0PyWxaJsg/l6LBiIyNlxdrCtVbUPEMbvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765049432; c=relaxed/simple;
	bh=SnLlmktVxOhCAKq/O6Fd3WpyShX9Y+kcpXs8799RpTg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LDFx/UVu7Ry7f8MIfwP13B8+kzTWV0CFu8U6xJDCRIfhribeiC7G87fWd4tbD0LWFCyP8m5VnqxvITyRe70x8Mv3jXhJPgzZhnTOpILLBeep7EfVXPiH90BsTkWEpZWkD1+T926+eimjV6q81D+Os8j1CGcPt62VwX791HoubkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=to0OXjXl; arc=fail smtp.client-ip=52.101.43.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="to0OXjXl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHOq9BXXPZqIeQZv7oIGCRu7jdQjsk2GK4YNJ2D+9hfwvN3r3ZI1pePxU1fZ9oZZEIy3FvbAh5Gjj9mj395qh20uEWBahmVHr9smA+SwbQnkFYNIU+Zl5aMzzWC9pTN0AqgToxL6t85x1QyjXEy13XmYWISx0ogv0uVMr6UvHLPHEYTlUZlQqeoEUA/JQAwN/qJAZzsA3kW6Ti6mH5iJlsy6o+j4Yt8nlWiE/QVGfcVnc/iYtPnZFLVaA2Ge1JiImQU/en8Q2Q1Tq/1IxHzGRoT2zgxu37d0cPkXhSKqm/Cxnt+rLqEBXL//sl0Kphfcs0Pc1lrCtFoeHsQNAZXvSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnLlmktVxOhCAKq/O6Fd3WpyShX9Y+kcpXs8799RpTg=;
 b=OkpAiMFE6EgKOexHNhowgbDEKiqa5rR+VNM9aHe+vp9uHxTIC0SA0fPHxaykVbRtDbGQe6bonuzBBVC5aIjtpedzsogSndUq3r9+qRN4mhssOe0YS7YiW6M7+McqX2AejacV71w0IG9nrc/7zpJi8qqgUoLpYgQet+dfHTGxkDdLByvcuMX+Fqb13W8wyMD9hRjRZ71AgQOO3vQ6WA99eiHzcIZTna7A/Kn+cX9Tfqzr/+ndyyvGlBNWVVhUVX6tF+J94ioHKDqsKx6rjQKtDXCX50DQHwlBzzD4IyO8wtc2Z4jtUNIg6PQe+wtq/6KSYLj1Hnb3Y7B9eRqQ7RsEAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnLlmktVxOhCAKq/O6Fd3WpyShX9Y+kcpXs8799RpTg=;
 b=to0OXjXl6gNA7DOGkFgYtT4OEyXmN3DstTzij7K0sNh7SXlRchw7gXMe4CgKsJmbMBe0F9DxXES26syKgH280+hVYXPifkWp6tIqnuZXbqrMgNQ9ZVdd2J/sfUeQs0eH1aWeMNcrubdIBu1ONwErtfo2h9vqcNdJ4lHaS3Nufnr9ZdKb7Wr6vUqCRAk4k1p7fwSJ5tWsWjkRrdk52EusoVBv+t4f/NxQZzzpeZX/HaKgfAT70K5OGX7HQepP4wRTQIAbT9FLdrb1grpY0bFpl3mcQwHqscRGotKVwPM9rz2NpRLFDu6F0BQgjGUsmJZZGjdmD640LZ4MUwNt8vUOww==
Received: from PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21)
 by SN7PR12MB8002.namprd12.prod.outlook.com (2603:10b6:806:34b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Sat, 6 Dec
 2025 19:30:25 +0000
Received: from PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6]) by PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6%4]) with mapi id 15.20.9388.003; Sat, 6 Dec 2025
 19:30:25 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Tejun Heo <tj@kernel.org>
CC: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, Steven
 Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Zimuzo
 Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon
	<will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng
	<boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya
	<metin.kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
	"sched-ext@lists.linux.dev" <sched-ext@lists.linux.dev>,
	"kernel-team@android.com" <kernel-team@android.com>
Subject: Re: [RFC][PATCH] sched/ext: Split curr|donor references properly
Thread-Topic: [RFC][PATCH] sched/ext: Split curr|donor references properly
Thread-Index: AQHcZlqmugcBTtjL0EO+yZ/bWEHM1bUUCrkAgACpqwCAABFpgIAAOwgh
Date: Sat, 6 Dec 2025 19:30:25 +0000
Message-ID: <26D75017-9432-4D8F-994C-ABF0B2A9F30B@nvidia.com>
References: <20251206001451.1418225-1-jstultz@google.com>
 <20251206024724.GA71744@joelbox2>
 <CANDhNCoe21MYZUmOoa7G0ecU9SJKTFtEp-LjOJXAsCj-ZpQb6Q@mail.gmail.com>
 <c31bc7c2-52b4-4a91-ae0f-259411145432@nvidia.com>
 <aTRSzTVeGfME1N5y@slm.duckdns.org>
In-Reply-To: <aTRSzTVeGfME1N5y@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8056:EE_|SN7PR12MB8002:EE_
x-ms-office365-filtering-correlation-id: f64cd34d-12a9-423b-5226-08de34fde7c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cVFmM1lyQkhUcVRpTVdhYTNvYnZrQzJWblpXYmJJeEpXS0hWQWNvaFFCMDVl?=
 =?utf-8?B?dzRKNExRK2F5NkVDOTVuWE9aeFBsWWd5V3UwRUI4dVRqbVVSWHZSVkdSckV2?=
 =?utf-8?B?Y3hHNGJMNHdFci9wZlMwS3ZlejZCZjBVNFRZSTlWaU90R2dWYVNzdkxCQzNE?=
 =?utf-8?B?bENLZmF4QVJtM0FBaVM3Q01aSlZlYzRuNjExVURNcE5YdlRiVGIxRzhXclU1?=
 =?utf-8?B?NGtvcXQwcExYNGljVEpoUS81bmRyOXpXUnEwYysybVh5SHc5em5veDlIclAy?=
 =?utf-8?B?M3N0dy9qcmxEb2dmWXErb25NamlJdnJqeXJyN1B4Tmh0TWcySjgyaG1mdFMv?=
 =?utf-8?B?NnhUZnc4N3lCUmtpUVhGV1NJUGpHM0NHVUZ1cUZSMkM3NU4rdEF3NmI5ZWUy?=
 =?utf-8?B?c1JwUTQwVlBQczFET0h2VkV0c2FSM1prVFVwbzZ5M1JQd0pKc0dCZ2s4N0Uy?=
 =?utf-8?B?b1VjRmxrWldpNjNpeDVDTUZLbDhLQUhJTm1FVG1XVUx6M2k4UUhRTGg4NzRq?=
 =?utf-8?B?SFNNTngxa2Z4SnE4NHpheVJlSVlnVnVtbU9nS0wvN1V0aFNsamJ6eTB2UG16?=
 =?utf-8?B?azBRdVdiSTFKUThpV2tQM3FVRGUwOWxOQ0NONmVPcmd2a3lPNXJqd3owcElS?=
 =?utf-8?B?WUg2b3IvaDZiSG1aRUh5SjlNa0FVTFk2SGtoVldmejJlcDZzbjNTZ2xoWVVl?=
 =?utf-8?B?SzNBb2s1TldENi96UUl0NDdJaVV6S0RjblAwREhhUWMxU1hXM2dFU1BWMEd2?=
 =?utf-8?B?Y3plSnNxNHBjZzduOGhZb1g0MGc4M3YzMFhZZjlPZlcrNHY5TVYxcHRNTzFQ?=
 =?utf-8?B?b2wyYnFVM00rdlV3cnhJeTVaTTZGZ3ZYOVFmRGFENkN6TDExS3lKSE5KNUlM?=
 =?utf-8?B?N1VmNmx3a2JJM1QwMzd5UUcvbjZQVEhzY3FHOHpqeS8vS1gxRUhrektxZStt?=
 =?utf-8?B?RURzbXpqRU9GNW5JT0xEbU54V0x4cys3bVMrV0lUTllWWEFlSEJkN21qYzNF?=
 =?utf-8?B?WHQvYTVGUkpsVytuQXFlTWZkVzI2UWNQZjhLS1RnRjkxR3JYZDZ6LzJtelUv?=
 =?utf-8?B?ak8zd3JHTTgvNGJMWnhwaFprUmUrdmdGQ3NMa3hLRktjSm9yd3RNSGxrM0oz?=
 =?utf-8?B?VG8vN01yaUJDMVV6OGxBN0ROR3NtbkNsUmpUelBoMFA5Mzg0TVhpVytrUFJI?=
 =?utf-8?B?VDhub3FnZE1DOFNvZ3U4VDdsa1ZWUzFRYmxxSUN1VXBmVld1RnFNd0FXeG5J?=
 =?utf-8?B?UTJNelZxU0tRVTVRa1V2aG9BT0VrSVcwVXhTNVFva2l0a3pRdVdtWjlJaWNk?=
 =?utf-8?B?dHUyWXNwdUVuYVc5NmhqOW5BZUJPZlR1WnJGN0ZyajdFTmlXTkl6clBTOERa?=
 =?utf-8?B?NW1VbU4zelljMVdlOEhiZkFFOTVTalZ3UkpUTzJhWVdtbkNscCswbkdMMXVG?=
 =?utf-8?B?YTloMmtBRjZ0NFA4MGJLRnd4cks3MitCdkZhVGtRWXc2N1J3UGtOSjUzUktV?=
 =?utf-8?B?YzYyREdtNzRiK3dFNVRpSDBBQVdiRngyUGoyT3QvSXZqVWswZ3hDRGp3Q1dl?=
 =?utf-8?B?VndIRTFWVnBYMHBOaDhPcUZDQ1IzSTM1Q3N6S013MG5HT01LcWo3d013OVhn?=
 =?utf-8?B?emdkNnFZc2wxWFNKUVVYOTZhN1RyZk9VOUZiWk0vREZSUE5penRVYlBtbmd2?=
 =?utf-8?B?S3lMbUtmRFl0YmNOK3Frb2JPb1hzTWpWNWphbEVRTUd1WkZvd25OKzFCL3cy?=
 =?utf-8?B?ajIybk5scEpCUVFQdXh4aDFDaHB3a3JkdGxETXFYTWhJelVja0hkeXVLOHpX?=
 =?utf-8?B?WTdrdndyRUVoM2pNUHE3SjlHb1VXb1ZFbjA2M2FLNXJLNmNtZVcyVEV5aHRw?=
 =?utf-8?B?RzJJV3NHMXFEUitSMG8vb3VvMHg1L1c5Yjg4cEh2SnAzeUQrMlJPMHJNa0h5?=
 =?utf-8?B?aXBCVzIxeDEvd3NzNkZ0TnU4Mkt1VUpmRE1MSDQ3Q3FXUG1DNFZFbmExQ2xy?=
 =?utf-8?B?c25VR3UyNDB5ZzEzQjNMVDFpK1d3OW1sbGF4a3JpbTJoNjZBMmo0cXY5ejFt?=
 =?utf-8?Q?LjMbwp?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8056.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVBFTk5Nc2lsREJrZlBnNTlrZ1UxeHZEckdySUhOaUhJQzQ4U2JzQXJtTXJR?=
 =?utf-8?B?VVRrbm5uTmJOeEV6VmczMlYvRVBRVkNtdGorMHMwRDByN1hwMmMyTm1EVmtV?=
 =?utf-8?B?TjEyOU9nZTE1a2swTld5UVJJNG1kNWVuU0sxUkxJMFJEcmhDdDVXZ0RSK3J6?=
 =?utf-8?B?Y3dyYnFCRVc0VWtxeFZOemVaMms1QllmL0ROMUhNYmczMVNzZUlYUkw2UVd6?=
 =?utf-8?B?SUtEUGlwTk0wSytnQmJSTUxvL1ZvKytPcXFITXQ2RHFPcGRrMDB4SVpOZFdX?=
 =?utf-8?B?UXdHTEIvUkNZbnEvekp1WDBzYXpzUEwvaEVkd2pmZkFyQWtLYisrM20wT0Vx?=
 =?utf-8?B?UG9aMytOV3I0UXprZFh2WVQ2NzhjTnVUdm1lbFJEdzUrclV3aXdjaGQwbmxQ?=
 =?utf-8?B?Y1UzMzF3Zmd6cGJYQStJMGZrdjdkeitoRU9vMSs1d29JSXFuNXlrTnRDWWRj?=
 =?utf-8?B?cUVaVmdFc0JuMERDR096SEhWckdOZytvZm83YjQvQnZKbHNUSFF3VENPNkNl?=
 =?utf-8?B?L05oeC8zUm1PTnlOQjY0R0RITkJaZ3F6TFpKT1N2NXNzQjg0VW5HSG5meWsy?=
 =?utf-8?B?azNRSjVQUGQ5RnhuNmIzUkdRSHJOT1U2TnhiZVZncVZQYjNub0pGNWE0dG9E?=
 =?utf-8?B?Wlkzc05FV2FINnRJUStId3Y4Sm15YUYvT05YZ3h0bkdJdlhBQ2pFd1FpdWcx?=
 =?utf-8?B?T1Vma1E0TnhMUmdOejdHc3JCc0ZscXR2Zk5CeTFkdXdRb0o4RzhMUWdCdjA5?=
 =?utf-8?B?WndlR0JueERFNmt1VXJ4RTBqYmJMQUE0NDhqc0Npc1JVYXlWU2hKUG1YS2Vm?=
 =?utf-8?B?S040SUk0djlCRnJuclZScDBkOGtTOVcxYTIvMjJxNm01dSt1dzBDcUl3ZlJY?=
 =?utf-8?B?aElTQ1Zhb1l1NlV0cXJPaFBwWjI2SHBxSEhLd2gxSWszbUJXNzRDdkljei9M?=
 =?utf-8?B?WGRZMVIyblBiRXRlOUE0M0w2N2o2VG9hc2NJOEpvNlo3SHkvVTQvdWhtRzdu?=
 =?utf-8?B?cUppdFJvTlFMdTFtS2JiRjR2aXBtR0FxcUt2QVNlbG93SVAxODVxUjUrZExL?=
 =?utf-8?B?bGJrbUlTclhBNVp3WS9KQTJsZkdTZk42bnFVejBOYWtEYmNDUmpUK2tuclcv?=
 =?utf-8?B?VWhxQWxZUWhVbzFnalU5eFNleGtXZ2JNRmdGNUppRVZoa2xlYkRKZElWNjV6?=
 =?utf-8?B?SDJLZ0FodUJPQmVzQkZOU3pEY2NkQlovcytHbnB4QzU1UncyelRxS3k0aTI1?=
 =?utf-8?B?a0FpQUx0Y291TE82Wi9CTUd5TkoxMW9EdndjOHNETzNyYTA2ZnRxVWFLczhm?=
 =?utf-8?B?SitmU3BKdFpBT2pEaGNnWmpZNEx5b1FKUkltUkpJZEFDVnNCNHl6WGdmNCtB?=
 =?utf-8?B?b0dCSjBYTGVjaFoxTysyUElURStYT3FnODR3VnNnaisrdDV5dkh6MDJYSzl5?=
 =?utf-8?B?VWMzcDhEZVdNZDhBS2ZJYXpxMUJSK2RMdGZjbzMvOWIyeFJZZnlrMzNyaGQx?=
 =?utf-8?B?L2NmMGRxVjhhZFp2UGgvT3d0aHQwdnp5ZzVrRGtnWlJZZGlKczRjbHIrM1Z3?=
 =?utf-8?B?Y2x5NjBjNHdBTytNQ0pQV2JCMGhHZUlDMSt0RDdUNkhNU3RZeW9XaW9kQ3U0?=
 =?utf-8?B?RzFzMU1YbHQvR0txZ3NQc000UmhoWEhDMng1K211UzVjR3lRTjEvQS9OdXV1?=
 =?utf-8?B?aTdYVURWdlhuKzRsMEdIdk5qLzRFTU9vVTFmNWtOR2xOREluV3lLRWZlZTdo?=
 =?utf-8?B?VTVvODhka3I2SG0zdURzZE5qZXNub3o5U2M4TDk2OXExZzlEWlI4QWRXcEhu?=
 =?utf-8?B?dzIwUko0OWJwWThnM1hVdVU1QUhHZTZUdGUrc2ZHb3FVNEpTcHlvWkFtcWlV?=
 =?utf-8?B?ZTN4aVNwd3VMaXJXclkyaVp5THQxSkUzZmQzcVF2TXB1V3NESWthdmw2NnU0?=
 =?utf-8?B?V0E5QnovRmpkUUpaK01ka0NJVjVOYWpGQ3VsbVFmQUVuL3JhckZNUDlBdE9Z?=
 =?utf-8?B?U2RUNDZhUjFFSTVDOG0wYXVoZDRiNGwvT0xXYXZFZm5CcXVFWWRzUzBjQlVp?=
 =?utf-8?B?TE5mbU1ya1A5UkRtTjNmOGtUZUZrZEtmS2NNSllidFFEQmtDTzNRbzJhS1VC?=
 =?utf-8?Q?E1W0PZ25vkyjnNec6Ithx9mua?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8056.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f64cd34d-12a9-423b-5226-08de34fde7c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2025 19:30:25.2916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o+ni+fzxdkdHSDVD0thskcF4aJHq9ABmgdDAGUjxX7Ts6Jzu3lgQxBEHYwo9M2ezAkZ/9Orht//USWbivFwJ1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8002

DQoNCj4gT24gRGVjIDYsIDIwMjUsIGF0IDEwOjU54oCvQU0sIFRlanVuIEhlbyA8dGpAa2VybmVs
Lm9yZz4gd3JvdGU6DQo+IA0KPiDvu79IZWxsbywNCj4gDQo+IE9uIFNhdCwgRGVjIDA2LCAyMDI1
IGF0IDA5OjU2OjUwQU0gLTA1MDAsIEpvZWwgRmVybmFuZGVzIHdyb3RlOg0KPiAuLi4NCj4+IEF0
IGEgaGlnaCBsZXZlbCwgbXkgdW5kZXJzdGFuZGluZyBpcyBCUEYgc2NoZWR1bGVycyBoYXZlIGEg
bG90IG9mIHNheSBpbiBob3cgdG8NCj4+IHNjaGVkdWxlIGluY2x1ZGluZyBwcmVjaXNlIHRpbWUg
c2xpY2UgYW5kIHByZWVtcHRpb24gY29udHJvbCAoZ2l2ZSBvciB0YWtlIGxldmVsDQo+PiBvZiBj
b250cm9sIGFuZCBwZXJmb3JtYW5jZSByZWFzb25zKS4gWW91IGNhbiBpbiBmYWN0IGhhdmUgeW91
ciBvd24gJ3VzZXJsYW5kJw0KPj4gcXVldWVzIHRoYXQgdGhlIGtlcm5lbCBpcyB1bmF3YXJlLCBJ
SVVDLiBJIGFtIG5vdCBzdXJlIGlmIHByb3h5IGV4ZWMgd2lsbA0KPj4gdHJhbnNwYXJlbnRseSB3
b3JrIGZvciBhbGwgdGhvc2UgdXNlY2FzZXMuIEl0IHdpbGwgcHJvYmFibHkgd29yayBwcm9wZXJs
eSBvbmx5DQo+PiB3aGVuIEJQRiBzY2hlZHVsaW5nIGluIHVzZXJsYW5kIGlzIHNpbXBsZSBhbmQg
bW9zdCBvZiB0aGUgc2NoZWR1bGluZyBpcyBkb25lIGJ5DQo+PiBub24tQlBGIGtlcm5lbCBjb2Rl
Lg0KPiANCj4gTWF5YmUgdGhpcyBjYW4gYmUgcmVzb2x2ZWQgYnkgcHJveHkgZXhlY3V0aW9uIGV4
cGxpY2l0bHkgdGVsbGluZyBzY2hlZF9leHQNCj4gdG8gZXNzZW50aWFsbHkgZGVxdWV1ZSB0aGUg
cHJveHktZXhlY3V0ZWQgdGFzayBzbyB0aGF0IGl0J3Mga2VwdCBtb3JlDQo+IHRyYW5zcGFyZW50
Lg0KDQpZZXMsIHBlcmhhcHMuDQoNCj4gSG93ZXZlciwgSSB3b25kZXIgd2hldGhlciBpdCdkIGJl
IGEgdXNlZnVsIGZpcnN0IHN0ZXAgdG8gZmlyc3QNCj4gZGVjb25mbGljdCB0aGUgdHdvIGNvbmZp
ZyBvcHRpb25zLiBpZS4gQWxsb3cgc2NoZWRfZXh0IGxvYWRpbmcgZGlzYWJsZSBwcm94eQ0KPiBl
eGVjdXRpb24gZHluYW1pY2FsbHkgc28gdGhhdCBwZW9wbGUgZG9uJ3QgaGF2ZSB0byBjaG9vc2Ug
YmV0d2VlbiB0aGUgdHdvDQo+IGNvbmZpZyBvcHRpb25zLiBJIGRvbid0IGtub3cgdGhlIGNvZGUg
aW50aW1hdGVseSwgYnV0LCBmcm9tIGp1c3Qgc2tpbW1pbmcNCj4gaXQsIGl0IGxvb2tzIGxpa2Ug
aXQgY2FuIGJlIGRyYWluZWQgd2l0aCBhIHN0YXRpYyBrZXkgYW5kIHNvbWUgcGVyY3B1DQo+IGNv
dW50ZXJzLg0KDQpBZ3JlZWQuIFRoZXJlIGlzIGFsc28gc3RvcF9tYWNoaW5lIGlmIGFsbCBlbHNl
IGZhaWxzIDopDQoNCnRoYW5rcywNCg0KIC0gSm9lbA0KDQo+IA0KPiBUaGFua3MuDQo+IA0KPiAt
LQ0KPiB0ZWp1bg0K
