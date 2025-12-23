Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012069.outbound.protection.outlook.com [52.101.53.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644B223FC49
	for <sched-ext@lists.linux.dev>; Tue, 23 Dec 2025 04:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766464447; cv=fail; b=SwZjvBdfvhuZx+1qeITUkTruc9Rw6O4pjl4Qb3gu/u4IGx6w51Wq0RRl3RIybOpnJNON7XizoCOiTe2jC81mOX7bIBbUNqREkzKoFSsTfRdGk5dGKGgvNAsHqZiIozXSV3EIhlBvWOvyZbTopE1TFp1Oyf5ZFE5/3Hl5nn5qcjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766464447; c=relaxed/simple;
	bh=3l4MeWWeWnhiDw0+GDb5eXm9qW44Z4cglHre0Q+4nks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZAqlwRD/kwD7Oc7v4FS2hwP+RXKetNxe3/wa1n8iABcztxjctfLM3D9jPqRRsPqj0u3IohK5txPLRTuY7SzU/VQm4af816KDKWn8WIUq6jkkqRY0+S8FixpljAln9OKfAGkhpafUIJ75XnKZFn42Be0fLdBUjsTJghlqG5V2/+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NOZwIqH9; arc=fail smtp.client-ip=52.101.53.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NOZwIqH9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRbERiCrhz0zlgBzRNl4n09gm0Cv+DTav4bqz1bi7MkzknXKYBMhtLTaIWO5cWFeOqG44XPeqo7g/J5qWb6swqJjUikrQJ11UJhn1WXuC5Lg7Z6/deHoVTnQYo4/8WNdJBxMcY5UUcTLmHNqyOQtk2YROPI7SgtvemH812hCDhbescQGP1YBJm+DWGp3/8GpRWOxhOWVxB6FOlqvgcJHnFM9xQMRLbvCimeNIQb71A8IWoDwyuvbji8VEnK7IukTCfTC1Mi0FSUntNtddiT2rrioUWtlDAfVQxz8nEK1enwAZFVQXp9GpVSh4I5wHADfF+y1Ctetzm0M6V5shygoJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3l4MeWWeWnhiDw0+GDb5eXm9qW44Z4cglHre0Q+4nks=;
 b=QjAy3GogczwUSHOUHqJwMR39nh5jcF23iNld4UNY5NB0+lckQiGnOSBHoxum7uZrh12x9BjT5ftQC96LmT5lMn8ddHGtsy2eSwMTzjpimF5jcMipBRbGFLymPXLrMG0tl81Uak0MWlLKbziJcoUI80cxr4mbwmgc5peGz9lO3w34skJ5MfoTn3EiVRgqEQrP/BW/49KHeZXI0yEcx3/oijvrMS67bLCLmawJzgoKvhjLBPgyW52HPdI9N0PvBNLsKUkyIdwf+Fxd4Zez9GonpiMRjwpRxD9wybAOMo2Djnhe8x3uBhFgZNsPwvze3MXRaM36UuL6z+jd+QmgWICVFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3l4MeWWeWnhiDw0+GDb5eXm9qW44Z4cglHre0Q+4nks=;
 b=NOZwIqH968gpvCyU5AjSyZH+twSa4f2DkR/NTNEw/K7gMDH3CXb4madQJlo3JVK6ZudDa0NpDve8iCy7V8PcNW1oBXj+c7+J5DAoSbG8evhmxZkEx8mWjOAQkMYNYwxF4z/ngv/zcs0YTewKRh3ggECiynHmm5z1tbxM8pTP9FVsr4zRW/dr+bgWbWv+0F0njOrGnOZWjgnMRv6m+aLvHhlomYpM80EyoMihsLCNx5HVPs1VvNt9BYA7C/QD5oe283kHDcG1bxF6sijjNRtVRH2noLdzQ94DnNxP8hnrx39diBXwTd5wpUA/nkZRYSlFA4zAMZxWWISyWXj46W26Mw==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH1PR12MB9598.namprd12.prod.outlook.com (2603:10b6:610:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 04:34:01 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 04:34:00 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Tejun Heo <tj@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David
 Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min
	<changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
	"sched-ext@lists.linux.dev" <sched-ext@lists.linux.dev>
Subject: Re: [RFT] sched_ext: Skip stack trace capture in NMI context
Thread-Topic: [RFT] sched_ext: Skip stack trace capture in NMI context
Thread-Index: AQHcc6YuWUnFmwPZKUOPGiAcbVMw5bUuhMiAgAAeo40=
Date: Tue, 23 Dec 2025 04:34:00 +0000
Message-ID: <9D417792-A0A8-44C4-884B-A3406D2E7A1D@nvidia.com>
References: <20251223005038.62406-1-joelagnelf@nvidia.com>
 <aUoCBVhHig737uKt@slm.duckdns.org>
In-Reply-To: <aUoCBVhHig737uKt@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|CH1PR12MB9598:EE_
x-ms-office365-filtering-correlation-id: c71f0570-ae39-4c89-b6c9-08de41dc7eb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TkpLVmx0SjZ5RTZmT3JZTzI0cXY4Z0NMekJxdE1sTHlCV1ZJR2JhMGJVc3hl?=
 =?utf-8?B?VWY4L2EzTDlOS1kxbGdkeHdOeEZRNGZNZThWU1BseStXVVJ2RmhyMC8vS0pM?=
 =?utf-8?B?SkExMHVxSEVNYVNNdjhEeWsxZE14dzIwdWNmOWVFMVpQdjduSFZ3Qi9kcjVo?=
 =?utf-8?B?MU5mR0tmbVdocjROd1loOTl4ajNQSXNLQzJ6MVpiRUdiT2lxYWcvOHdxOStH?=
 =?utf-8?B?Q1RxRjJ5bGlpWDBmSERMak5KZ3NvUzhqaEZzRWNCSm1MbnE1ajQ2ZW1SWGRk?=
 =?utf-8?B?a1c2TENZYzV0MWZmSnJESTRkWk5xUUozN0RESTVSWkZ2RjI1T1gyUk9MU3Rm?=
 =?utf-8?B?NUR1RWE5M2hYNW5qaXpsZzI3T0xSd0FXbStUS1BvR1JRTTd5WTlMcHgrNGpI?=
 =?utf-8?B?NlZpaXNkQlRYbCtoWVQwdmlEWVFFSEpGdEZ4QUcyQXNvUG9CdGdMQklmZ0Jq?=
 =?utf-8?B?RDBkNFh1WUk3dDdNYVJUaWdXcUsveGFrcUNhell4SGgrcXlBbk1kOUlBWWZB?=
 =?utf-8?B?UVZIa2ZrYThzVjNwdGFRQlRjTktQbkxmSUxPQzk5ZXpvLzVhSExkNjNYZjIy?=
 =?utf-8?B?QVFpZWk3MlU3VVpja2RVU0pkaytEZDhSZFNoZ0RFenBKMWZCdE1DdXBMUEVK?=
 =?utf-8?B?bzJ5WHNpenJDR1grSFM1dXVRYUQwUGFHNGw5MlAyUFdSRHgzalNBc2ExNTgv?=
 =?utf-8?B?ZDBnc0dXVjBtNzlMYXIrYTNWYTBFMmFNUnlGeHdNSitxMHp5dVhXVEhyWjhG?=
 =?utf-8?B?SXBuT29pOEwzQUtEVXM1aHYxdWlDSmVNS0FQemdVSy9vbDdKcjN2U2xKalRj?=
 =?utf-8?B?MWtCSzlRZDNUZjR6THFZa29XMnljWHdQVEk4NFVmTTVodkh5Sk9wdzNtR0c3?=
 =?utf-8?B?aW8rTlAybjR0Z1NrSXpLNVhjMnRUSTNNdXIzREgrbXppdGwyM29JQUZVNTVK?=
 =?utf-8?B?WHYvcTJ2bHJ6YW51SmZiL3dYV29LYTRBanBjNnl0bUxWdWY5QStyNzNueFdj?=
 =?utf-8?B?aThuYW1wYzdFcktMMHB4bXZUVml6QjJiQ3R1clhjajhDTlVFRGxzYnR4MC92?=
 =?utf-8?B?Z0FuOUh1ekFmK20za0M3V2M1WmlZRXpkYUEzTlVhbzArcWR2Q2NEcllja3hS?=
 =?utf-8?B?anIxUVNjMksyUGQyRVhnWnVlVE1TYUMrZmxTbTUxZ092bTNQSm80VVB4R1hY?=
 =?utf-8?B?dUMrUzlEQjR2aVdHVlRKRW44RWlxSXNXTEY4bzlrSzZXL0RiMjZXNWJPRmtS?=
 =?utf-8?B?ckNwRHNabHl1N1RjSngwemtmRlpoTWVsejJDTVBBb3VpdUdlQkRybWVWUTUw?=
 =?utf-8?B?ZFhaMTR3TVpjVEFBai9UMEdvNHlYMlBSZlMyWHBDMEx2K3FRQ2RpUVZlVFVp?=
 =?utf-8?B?QXRKWmtmSDI0enRaNWxheisvRmlpRmxEMC93Ti9Ca0J6aEJJV2s5QXNkUUhV?=
 =?utf-8?B?dUR1YzRIRllxM0Mvd0xJM0Rxb2tkTDg4bDk1TkpxV0hzYnlQaklRVDVUb3k4?=
 =?utf-8?B?c1FBdDhyVTQ0QTV3Wno5YWxKWTJka1VVWEV3V3dCVXF2RGNKcmRITlZsQkNR?=
 =?utf-8?B?V0lYclZ4TVNQU0lqd1g1bW5kell0aWxMNFBrZjAxMkpZRCtpTFQwbTE3T21q?=
 =?utf-8?B?UjJscFBTMHBNbS9qa3cyeVZMeEQyUUphbjBQL3QzOHMyMTNqR1RLVVpKSnUx?=
 =?utf-8?B?dXp2NlVsWkQxVXAzeEtnblBObEFCWXFnbEpOYzN0c2tyYjlGcDRSQS9Na3pP?=
 =?utf-8?B?VXNvcGZFM1ExR2pqU0VxUGRpVWttV21jWU9GRDFMOEhFWHI0czVUQXN5ZjRE?=
 =?utf-8?B?amtFK1dMTTBNejhDcHJDdmRBK2xFV00zTnJmd1NudnJOOXhybzZQY3ZDWDYy?=
 =?utf-8?B?Nk1NZUhyMHVWQlVRaWxqdFdBRkVnS1pYSThsUzE5OUMvbVVZYU1CQVY2bEtC?=
 =?utf-8?B?enRSNFBuWDMrYlNXT0FpbUxKNDBFK295NnpUc3ozVlJVQmtDU2YxS05jSlJt?=
 =?utf-8?B?QVdaNXBmaktsSG5FUU1obW9nUDN4ZmhDckcyUTJac2ZCVHloZFV5TnBDYlVw?=
 =?utf-8?Q?py67uz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NExtb056L1h2QnJjOGQ1RURzUEl3N2pmKzNWU05Ec3FyekVpT1R3QVBoaHhM?=
 =?utf-8?B?VDg3M3VUbWVldGp2M2hFMy9NWUZSU1NDcjdZeDdxbDVkVjNPUjdsdUZxQU9G?=
 =?utf-8?B?OS82eGNRS0pFN003ZTVYVzk5WUhUeGlsU25NTmVkRGhxTkdKTlc5clBBb0Vm?=
 =?utf-8?B?bHpTaEFWZ3BQbm9nMlUvc0dlUVJhRndiSFJLMGJKM1dEYnVhYmQ1TWJKMTRO?=
 =?utf-8?B?dzJkS083bFNoQS9hQ2hUdkJhNGZkeUNreVVPZ2tONUVtV2RiUDNIKzZ2Wkd0?=
 =?utf-8?B?c1pldnFONzR5a0l0VzdJRzdqRjh4MlV6NFpETkMxUlRwcTFQOSt6ZENrRmdo?=
 =?utf-8?B?SUVNczU0S21FZ2QrVTNTMXlmdERHM0hKYzZnRU1CSldoS3k4NEhOVEFTby9r?=
 =?utf-8?B?Q054Z2Y4em5CeFNFcWZKejFZS3RRSENMMndBd0FEZWs0MmFvQlh2aHpRc2d1?=
 =?utf-8?B?alp2OTg1SXlTWjZaTDlkSzVlUVJrREN5MTNYV0RIMzNEWWdoam5wM1RnbEVT?=
 =?utf-8?B?bVVtVHQ0RWdFM2ZCMURMUDRqQ3FaWnBBcEZYMzdSaDBPZVB5ckhHeDBZbm9B?=
 =?utf-8?B?anpoS21DcEZwWlBqMjdqa21hdDEyeXRhSUpVM2NFeU9pUWNkbFNkQ2RjTml6?=
 =?utf-8?B?ZDlEYmYrb2JGM3czbjRaa1ZiR2RoUzRadXgrL0lFVURpZ2EybTFFK21mQzBp?=
 =?utf-8?B?eVdzNEZrVWZhOW9aVkRvaEVkdjA5NGwybkpPQUpDYWZQdUkwOG50bXJWcUJ4?=
 =?utf-8?B?SjZFMDdWUGZVQUlmTVVCVEY4KzQzSjlrY0VVZWRzM2ttd2M1djRjNmFoMjYx?=
 =?utf-8?B?K2NVWjlaOW9pZGwrUE5lUFhJZElJSTNqaWNZa2pCWDNXQjJ0NDNyeVE3NkVT?=
 =?utf-8?B?dmZFWGsyNnYreFdxamZ0REExRm52Qm51ZDRuTkpGM1VuMnhVanZFVWJ0VDhN?=
 =?utf-8?B?U3k0dzUwc1U1cGM2WkRIZ2U3eWVtckwyZ3g3ZXV0VDNlV1diOXJMMVFIWENG?=
 =?utf-8?B?alMrZkNEeUNsdk9hQ29nZUV2Z0xZZ2IzdlVEOGZ5L25aN1R6SXgxQ3RBL1BG?=
 =?utf-8?B?WnpKdDRkZi9LQys0UWlJbjY4S3RuVjkwdUtjMUxBMkZHU05lWmE5TTk0SlVy?=
 =?utf-8?B?aW9scnVKUXo4VUdMdWhRYnBoRE10RCt2akRJdjJ5YnVBSzA5V0d2QXJNanVE?=
 =?utf-8?B?dkVNaWxoMlgrejhZM2JvRTFSSDZ5RlJveG1RbU80WjBHalR2QzA1SXlUb1I1?=
 =?utf-8?B?R1pzL3J0YnZxQm93NFV1alNpU3l6UTYzVFAzRDdGZHp4VTVIRk1iOWxPdGlT?=
 =?utf-8?B?cm55SGpvQ2d4SklKYnpTc3NTUGNKdnJwTFU4LzRpWVBadkllR3lBVWZyNXpF?=
 =?utf-8?B?Y0tYL29aSE5vTnoxTUxYQkhDdWNad2hkS3JNcFJ6a3B3dVBWUi9yV3g5cmdY?=
 =?utf-8?B?R2M5ei81bUtEUGhYdWhIejNmR2lXSHNyV2wrTGZuejFId2pxOE9udjR6WmJo?=
 =?utf-8?B?ZVUrYzhoVU8vQXNPbU81TnRSS1pRNGZGdnY0SGtPK05Rd25lN2NYcmF0ME92?=
 =?utf-8?B?WUtEZzM1Vk9IbzRWZ0c2TkdLQ0JRNyt2ZFFiR0N4ekM3WS9OOVVRaC9nNUp5?=
 =?utf-8?B?ZGY2RWwvRjc1b2tCdGhMYmdhSjRFU2Q0a01kZllsZGtLMXdra3lyeStvQ2Zv?=
 =?utf-8?B?UTNESE5iWDhOUXhVQlRrZzZBWFhkNU1BWXYxaWRlMkJuNEVFZU1ScnFmbyth?=
 =?utf-8?B?K2o1Wjhsb2xjZ2p1UjJXRTJYVnNqY2wycHZJVkZRL09iZ1NzZXkwTVUyeEpE?=
 =?utf-8?B?aHgxdmdsS1pmaUJqK29QTThBZ2lmUnZ3Z3phY3NFMzZ6Y0dCc3FsZ2VXYnVF?=
 =?utf-8?B?bkZlUktnM2FWWWFFU09Qd3VzOTNwZTZXdkVta3QvUHpwZ0hCOVJnMkhOcm1k?=
 =?utf-8?B?dDVOQk10dkVYRXBIZDRvQlk3MzdmMkRueUlwMXVwTFZhYW0vQ1lNbmd0YVJD?=
 =?utf-8?B?VWhwMUMwSUlodmtCQjFiVU9hS29wNWZpQUx4MlFibExoNms4MHJoQ0RZOXhS?=
 =?utf-8?B?Yi9EaElBdHFtdXM5YkhpdWdhTnF4TzlWVDJ1MzQvVnZQSWNQOEc4YTZQcCsz?=
 =?utf-8?B?VUpPczBOaGpMSm16TVR3ekROWlZ5cUJLRzRSMFpzNkE4bSt4S0tkaHVRaHlN?=
 =?utf-8?B?eS9HVDdVK2R4ZEl3Rmswc3ROVU9hWjd4eFJKS3VaVVVQdVdkbmExVklrOWw5?=
 =?utf-8?B?djdjeFZQSmZXRzlXZEpGR2ZyS0MzWkNDL1hXTm9TdFBPZVZtS2dqN04vanJO?=
 =?utf-8?B?QWd6QjZSSHJVZWh1WmZRTGowNVhneHBGeVd0KzBsWlAvRUVxaUM4UT09?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71f0570-ae39-4c89-b6c9-08de41dc7eb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 04:34:00.6999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mKyAYqbC2wTdoz0zHh1KwQzrBFhTOxMzHtidRd71XWjQe45zbuemRXJQNk+U5blf9VkDbINgRxSdcws2sPz6kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9598

DQoNCj4gT24gRGVjIDIyLCAyMDI1LCBhdCA5OjQ04oCvUE0sIFRlanVuIEhlbyA8dGpAa2VybmVs
Lm9yZz4gd3JvdGU6DQo+IA0KPiDvu79IZWxsbywNCj4gDQo+PiBPbiBNb24sIERlYyAyMiwgMjAy
NSBhdCAwNzo1MDozN1BNIC0wNTAwLCBKb2VsIEZlcm5hbmRlcyB3cm90ZToNCj4+IHN0YWNrX3Ry
YWNlX3NhdmUoKSBpcyBub3QgZ3VhcmFudGVlZCB0byBiZSBOTUktc2FmZSBvbiBhbGwNCj4+IGFy
Y2hpdGVjdHVyZXMuDQo+PiANCj4+IFRoZSBoYXJkbG9ja3VwIGRldGVjdG9yIGNhbGxzIGludG8g
c2NoZWRfZXh0IHZpYSB0aGUgZm9sbG93aW5nIGNhbGwNCj4+IGNoYWluIHdoZW4gYW4gTk1JIG9j
Y3VyczoNCj4+IA0KPj4gIHdhdGNoZG9nX292ZXJmbG93X2NhbGxiYWNrKCkNCj4+ICAgIHdhdGNo
ZG9nX2hhcmRsb2NrdXBfY2hlY2soKQ0KPj4gICAgICBzY3hfaGFyZGxvY2t1cCgpDQo+PiAgICAg
ICAgc3RhY2tfdHJhY2Vfc2F2ZSgpDQo+PiANCj4+IFNraXAgc3RhY2sgdHJhY2UgY2FwdHVyZSB3
aGVuIGluX25taSgpIHJldHVybnMgdHJ1ZSB0byBwcmV2ZW50DQo+PiBwb3RlbnRpYWwgZGVhZGxv
Y2tzLg0KPj4gDQo+PiBGaXhlczogNTgyZjcwMGUxYmRjICgic2NoZWRfZXh0OiBIb29rIHVwIGhh
cmRsb2NrdXAgZGV0ZWN0b3IiKQ0KPj4gU2lnbmVkLW9mZi1ieTogSm9lbCBGZXJuYW5kZXMgPGpv
ZWxhZ25lbGZAbnZpZGlhLmNvbT4NCj4gDQo+IFRoaXMgZG9lcyB3b3JrIG9uIHg4NiAocmlnaHQ/
KSBhbmQgaXMgdXNlZnVsIGluIHVuZGVyc3RhbmRpbmcgd2hhdCB0aGUNCj4gdW5kZXJseWluZyBw
cm9ibGVtIGlzLiBJdCdkIGJlIGdyZWF0IGlmIHRoZXJlJ3MgYSBjb25maWcgZmxhZyB3ZSBjYW4g
dGVzdA0KPiBidXQgaWYgbm90IGNhbiB3ZSBzcGVjaWZpY2FsbHkgZXhjbHVkZSBhcmNocyB3aGlj
aCBhcmUga25vd24gdG8gbm90IHdvcms/DQoNCllvdSBhcmUgcmlnaHQgdGhhdCB3ZSB3aWxsIG1p
c3Mgb3V0IG9uIGFyY2hpdGVjdHVyZXMgd2hlcmUgdGhpcyBpcyBzYWZlLiBXZSBzaG91bGQgbWFr
ZSBpdCBtb3JlIHNwZWNpZmljLiBJIGFtIHdvbmRlcmluZyBpZiBTdGV2ZW4gUm9zdGVkdCBoYXMg
YW55IHRob3VnaHRzIGhlcmUgc2luY2UgaGUgaXMgYWN0aXZlbHkgd29ya2luZyBvbiBzdGFjayB0
cmFjaW5nL3Vud2luZGluZyBhbmQgaGFzIG1hZGUgc2ltaWxhciBjb21taXRzIGluIHRoZSBwYXN0
IHdoZXJlIGhlIHJlc3RyaWN0ZWQgc3RhY2sgdHJhY2luZyBpbiBhbiBOTUkgY29udGV4dC4NCg0K
UGVyIG15IHVuZGVyc3RhbmRpbmcsIHN0YWNrIHRyYWNlIHVud2luZGluZyBpcyBub3Qgc2FmZS92
YWxpZCB0byBkbyBvbiBhcmNoaXRlY3R1cmVzIHdoZXJlIHRoZSBOTUkgY29udGV4dCBkb2VzIG5v
dCBoYXZlIGl0cyBvd24gc3RhY2suIEJ1dCBJIGNvdWxkIHN0YW5kIGNvcnJlY3RlZCwgaGVuY2Ug
SSBtYXJrZWQgdGhpcyBhcyBhbiBSRlQuICBJdCBpcyBzYWZlIHRvIGRvIG9uIDY0LWJpdCB4ODYs
IGJ1dCBub3Qgb24gMzItYml0IHg4NiBhbmQgb3RoZXIgc2FtZS1zdGFjayBhcmNoaXRlY3R1cmVz
Lg0KDQpJZiB3ZSBmZWVsIHRoYXQgdGhpcyBpcyBub3QgYW4gaXNzdWUsIHRoZW4gdGhhdCBpcyBm
aW5lIHdpdGggbWUgKGFuZCBzb3JyeSBmb3IgdGhlIG5vaXNlKSwgYnV0IEkganVzdCB3YW50ZWQg
dG8gcmFpc2UgaXQgYW55d2F5IGp1c3QgaW4gY2FzZS4gU29vbmVyIG9yIGxhdGVyIHNvbWVvbmUg
cnVubmluZyBzY3ggb24gYW4gb2RkIGFyY2hpdGVjdHVyZSBtaWdodCBjb21wbGFpbnQuDQoNClRo
YW5rcyENCg0KIC0gSm9lbA0KDQoNCg0KDQo+IA0KPiBUaGFua3MuDQo+IA0KPiAtLQ0KPiB0ZWp1
bg0K
