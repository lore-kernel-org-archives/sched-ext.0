Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011024.outbound.protection.outlook.com [40.93.194.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BEB340A79
	for <sched-ext@lists.linux.dev>; Tue, 21 Oct 2025 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058652; cv=fail; b=ibjaSIBn9i63G0jluaOPC6yRQ98XUxkfvqeWrHtkD0dBUh9z/EbmHFDHJvAHRF1bHFGKUmgydhd7NisONdoQhvy6I+lBjUHqJM2Z600awT4fdFYFZCKgKnE+FOb40rO6bd/no+s0nesZKbZgJYC/DlMzubn+e2YG2zERCN/f9hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058652; c=relaxed/simple;
	bh=+8aOvBxVMSSU+9EcVmZT1UO9IEAB2IEAPCJNa1XJqQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WEWR2vEfxmQeZv1Q/CAMAnG7NiaohCPY5tuENAIvg+EnnL2wQu2oNT1TjAEIQw7ucy2PY2D8rrfdvCRs0RMQP77+Wh93m/Cefj46ttE+/c8EJ0ZV9+lydum/szXKiyf0o75fEcgBsg3JyJN64ijZDgRGAuLyMNh5gGaTyYHk4zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G8U7Otzt; arc=fail smtp.client-ip=40.93.194.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G8U7Otzt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P36VWSqnRP0qgOWLawwQ6i+k8bd3o2Vwh11fHKsbyyRy2KWh2g2pgsUR6xne7HT1ucvkJ+B3fQ2HIdzTVL0BdQBQPnbAr0CYTshoObGJKTawMcDBfuhO8mOZzCY9EOvTi1bwdIZUS6gzDxCJm3lZzcpSY+YY57KXxWFxEd2buutkgIueX3yzwXurekX1hl67q7oKx0xKVH64QVML4tJ/2pDGzHl7OslgRhKPSmEfHyBlZwt0RnQ94qEsrU2vpzRz8mA707bIa5M0Q6HZJXE8dPgf1QI3+Wb34fb54mNJYpi6DSS1cFdyOAJ7pUx2F7I29zhSTDxxl30NGzeJahr3Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPnnAOtQiNdnzSPuL7boKC+uGbgMnLWA7VoGkyuHUkw=;
 b=Ry2aoZMQ02fc8szYo3gAeFQGOSjG4AfvnCtOWhEMtT5aM7rqAMBxmrtm5LnMwJYvTQZ9XRRI/iP1Zj+UCBCC/vamrXeIGHOYBWmaupd58cQ3uFLrVWEXiqP3bN++frA/FxOfBP1iqtC7CLtCmWrwdA7oORm+HXN51jGOpu7Pt1q/JdPgiLm7mElikOoiINWiKqgkQVwMFaFobrVLxtzksDwlD4dDYDWeJiaaUR+MTu2+WuteEcDgXkpXlLeMe9cVlU60hicWIpRzSSCaDi59KmQ5Ft7+2B0LjQovYaxdKYh/CYytKQ7yKgCB27a5JXAyBNtJ0a4XQnH2PZMsXFvwpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPnnAOtQiNdnzSPuL7boKC+uGbgMnLWA7VoGkyuHUkw=;
 b=G8U7Otzt9pNW0zOSWP6LrkyZJYjWRmfUwUtOT8Gi2VLj1CJeY5CsJ+6tnKuUBLRh/A6NXKXFBPjL7nELxmLs0wtWaZnv1mA/yg+pQUF1tDAGgBk/XMYGjd+l9ayk2srwxXjZ9WJ3VDY/fdgGy5FK2XVfn48M27VL3SYK1uPzbXze1gR3uai4Stx+3mRk4fodPSmW6bAzWr/g9JHPPvry7E8RjLqYu9fTqir8nsfaav2dlHdCsDi2fNaF+uFHl39aiwbP4kY7hl2RVOGx85q4R4Jxr7pXu2kMK18F6v3atNbPk+cJL+GVei2WhK9968X0hZHzEgXB9ytCxd6d7eT2ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB8299.namprd12.prod.outlook.com (2603:10b6:930:6c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 14:57:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 14:57:26 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] sched: Expose sd_llc_shared->has_idle_cores other sched classes
Date: Tue, 21 Oct 2025 16:55:41 +0200
Message-ID: <20251021145706.61534-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0002.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de67d4d-5a33-460c-c230-08de10b22643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r0Zn+WhVcFdHKCxi2/7giI9aWMHq7CrCHXdqC+Xm71SQF3/nGacb6c+IsQTT?=
 =?us-ascii?Q?PIE40f5kIMVXhFJyWUiG7SaPOmVdRfeP0WGVOF/V4YGulBpTGQvbTOEJWUj3?=
 =?us-ascii?Q?22OPa7U02zT50kwyGj1EQoWCGA/nokUUuaKESfk1keKhv3IFFp69ta2cP69L?=
 =?us-ascii?Q?nIf4bvv77XgGEhQpch/69zznpqj2u566x71go26Ho+QZkAEGe5SiqPUWCnk4?=
 =?us-ascii?Q?EyiP7sYl0piBqsalbuuvUig5zCpbYh/d2zP85DHdgcvGMP3amh9rgr3Td7b4?=
 =?us-ascii?Q?acemtvdr8qNaN+A1KS3eHUy4EoTHo8g/RpfdsuPi0ra/kdJK37rsFqRzbTVE?=
 =?us-ascii?Q?VvaoAdleoVoFHZPfmkev37lgXrEkMAJER7dgx0EXRLX/9DtIqc8N0ZqTaus+?=
 =?us-ascii?Q?pYUeWMI3PTyIYdGiyxAGImTV8PrXMfjU1EvMXYC7OMOJ6R0SYQPLwgwwUAwG?=
 =?us-ascii?Q?r7kWkm3iWtOzxBn69hXDcbooUuI36VD0eNOXPV4R4T96kVvATsg2h94OBvGA?=
 =?us-ascii?Q?UlJRZjWZ3eox9S1K0M1/TxE8G1z//w87KoBCvMJnz5UflX1zE1q0wzsyiY+e?=
 =?us-ascii?Q?xssFV6xcaVVtb0ulNe3YY7dR0DRzP3j+ehOCrptcXccWxYAajicx9xC/BGW1?=
 =?us-ascii?Q?VjN8fU6tEZCdqEckzQDTUHoH2X79Pz4syWPrYM2Nwb9+HXpQMFR9Nb95Qvcl?=
 =?us-ascii?Q?TvPdfV9hS/fbzVZsdrwfZEdGDQuxE64rkTDmFYP+ab7wT5MJjsaxk7oK0hak?=
 =?us-ascii?Q?VmMzE/fe+7nKmqkO7eUU4oSAKPr6DIARXtkWaobCA7Tcx2RzIUhQby09m8l9?=
 =?us-ascii?Q?pSdGuKXJdcZfi7efCe8+AmzLSSrXAp/nszc0GFCel87laTk+LKIQ4xuYDyzp?=
 =?us-ascii?Q?Te9itXHbbnadCr4TQZQ4nqGZEO8cWTQZ93WXkdoWz1qZG7cpgPhG0VK51Csj?=
 =?us-ascii?Q?k2nU4/MKYc6D5ZqLoCw6OXkbljkgrVopx9PEcO2NebNNAFpc2aafXvLt517s?=
 =?us-ascii?Q?ygUbXe7TlN7Kxv5quqMyHarUTE1x8rGEn+T6SGhoKu+or/PzlF3mHm9riGf7?=
 =?us-ascii?Q?fBg9DuSI5vp4NOd6RRuuyMYBnfD/Q1MOBnNRwUDS+WZua2iHNKlSNfLNXgm1?=
 =?us-ascii?Q?idjGCgCOdIkwJjeL479P8zh2C02XknpJUn72bglwPa65NNBGXE3jrWknGT6c?=
 =?us-ascii?Q?UC7RRazZnupwi7vxLoNW9jmE/pVN/bYvRLHOPCbEc/rajEWSHxQqpwkrFf/0?=
 =?us-ascii?Q?xKpUUqa2MTCuIpkKXsh4eadxbMhxzFbvSejv7Y29ySJAu9WkNDcOJXlq59Gr?=
 =?us-ascii?Q?0O1RrTkUopTK9Sr76RmYT/xIm2AFzgw4Z6z0S0+KDsbEILRrblWq8CkEPO8D?=
 =?us-ascii?Q?jFInyb0QK45+83/htxjtdZgxOxS9OzUBxhCbfOarGEancbC+gxcH/+U82hWt?=
 =?us-ascii?Q?7zkRepHJ1HkPxu1k54aVBVvSATK5prHw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BEsfuc2ASCTxSkZdIAlhFec/sYCtOZgYme+hLKukpSUzJi7rPzhnBtFze30S?=
 =?us-ascii?Q?AaUq1cQ0wzaewYA3jh7o45hMIjCDYsKe+d2YD9+3Wp19QA6nPt7NaYpXatGo?=
 =?us-ascii?Q?1cqIBAdR/sOQ7/nB0lbH27uzvUYnYrj4xmQRzRbpd5uKFcEWhNI9GV8mdxUA?=
 =?us-ascii?Q?muEsCtrd6Cf39bMqaHSVtkhXos2lEQX4h1qDSepzuRZmaFkCRIboEr/fa/wN?=
 =?us-ascii?Q?+DR07bSNe7USF+BS46j1zTuo+w2xUxebeqbOW3bCrKmex/Ff/gf71U3eR88C?=
 =?us-ascii?Q?Br+3LMWk5QuN2HbuRw7ynap0ArmlIjB7SbXzF9jFO90bpA+Kq0VmvpmfR581?=
 =?us-ascii?Q?iWLt9tHtJyvr8ctzK48FJr/mU5nostB9hu8c7GzmrAF6uuuBYsq5J2F++91b?=
 =?us-ascii?Q?fiDwqOiq7x97YWdjKUuI15B3iIuYF65v21irJFkAEfaYb/uPcbDZwNJsJaGV?=
 =?us-ascii?Q?Yk1cLfX617B4FGlY8uiyzSWLedh5qv2pt+Fn0RtfW3w9BfM5CR1TMe7Vrqc1?=
 =?us-ascii?Q?9+nODY/UOtJajnQJHFeluXXR994Hh33jqdQyRf0e/Rycz+f7Q7LFSE6kYazr?=
 =?us-ascii?Q?rIloJerF7FmW7twuVtyahZB2dPgBSPgnDwoW0UUBdqjuGP5uU4rG7hQee9M4?=
 =?us-ascii?Q?M/o4XGRI6U67QrKs0ZDh0yzmjBbtNUGtGLGc/v5OmlISZkhhSKKJmktIUm/B?=
 =?us-ascii?Q?C8UqWP9Ix5BGES0K0qsDtvFXqeMRqtDGTdI0IG2VfMA5OfAWiiGvvSOmBqMU?=
 =?us-ascii?Q?kjbJ34V/JPp2SPlHgjkJRsrwAY0ULHBfgECUkKqBGvsQ8OGm60pzFOD7hJdC?=
 =?us-ascii?Q?AQzoCwv3wDLWQHb9zLxlG7noVFZFeU8uVwabB1S+EMaks1bnvNGy1XAf/qW5?=
 =?us-ascii?Q?w3U4wE2gTPChGKHRLh7AH2H8LrI25TpkubQrwSlctHW2708AvKWyLIFc7USQ?=
 =?us-ascii?Q?Ylyf/2tw/gEC1ddPsFOzm1uDUOWjo2nppi46TouAVUu/jSle1H979gFj7lxz?=
 =?us-ascii?Q?q/V1uSUuTwyuyIx5TOa69Mi1pQH7Fp9sxUSAkYV9hC/WQGvrbnJzCL8B/zx5?=
 =?us-ascii?Q?k+o/ZyHdDxUe1uu044aZ9eCV6i2KrXQQumMvMn6WPpnmORbPTZ9BCZPCvYCp?=
 =?us-ascii?Q?ONYYO47GfZQyoGyYXr68TMrciMjEI5sIZPcNGN5/T+zwEWdO10Utfi9Bsem/?=
 =?us-ascii?Q?rlYKnvRABZtqOvitEtKyQqMW0+lijW/oBnXKkSBFTllsdbi2wK8nbW8pdR0L?=
 =?us-ascii?Q?oU6AJLfr7oCkczagadfqRDrpaiwDz9rGRvHorjgZno0MQV+mCj7meTeqsH9+?=
 =?us-ascii?Q?Ypy0OI8x+Vji0jyevt9t+EN2hhHSITTmozV9B/0/KZ04zjy7Y2GSC5gYsC/4?=
 =?us-ascii?Q?oh6EpbxXuCAlJM5LEroC3u82nyFr4l/wqM6MWS2XA+hgO3igEVt6ALpluDT9?=
 =?us-ascii?Q?eSs8DBqwBjEgplHwxXW11X2qa2aoGyF4pjtfgWqk9guGRKrfkUystxdL9N3C?=
 =?us-ascii?Q?4zLGbvYtaCGj35ppho+Iik20Th496V+9akh/8O9Yq/SYZuuOyy6+crUxCVP0?=
 =?us-ascii?Q?u03oN+gae/IeFEiuucbpyyQrgiKgO9xh37dVI6+y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de67d4d-5a33-460c-c230-08de10b22643
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 14:57:26.7870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mPSjzdwWO67pi8wRJ3B3wkbgpwNZaBT6gbXV22p1YC/jEC4gC+8T+Fk/MwW0J4yW3xXwjfooEkbYayRM9633g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8299

This patchset relocates code to make sd_llc_shared->has_idle_cores
available to other scheduling classes and updates the sched_ext built-in
idle CPU selection policy to make use of it.

Andrea Righi (3):
      sched: Relocate sched_smt_present definition to core.c
      sched: Expose sd_llc_shared->has_idle_cores to other sched classes
      sched_ext: idle: Reuse sd_llc_shared->has_idle_cores

 kernel/sched/core.c     |  5 ++++
 kernel/sched/ext_idle.c |  9 ++++++-
 kernel/sched/fair.c     | 66 +------------------------------------------------
 kernel/sched/idle.c     | 31 +++++++++++++++++++++++
 kernel/sched/sched.h    | 55 +++++++++++++++++++++++++++++++----------
 5 files changed, 87 insertions(+), 79 deletions(-)
