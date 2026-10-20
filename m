Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792485932;
	b=CkI+1Z1CTJ8TO9orxLvEKmAGL+Ekpz+izR01Sn8W0M7TW3ky56HWroNDOitgcB5u1opI
	 87MlkGQ8SXp4HRlKBLVsaLFFgyk8QmtTymIhIYK9bJP7UwRLogNOuZGsq7wJ+yYYJZQoL
	 aOE4U/FLTfv4EymHNZlhh1X1DWa/J8IyGFVm4xBWGaJEHWWn6y/HK5VdCPvqW29XwkosI
	 epFR7WVNLKMJHQyQooYQJAUEMl4W39Hnol8RpQJQizEDfvX3xZxGP7YCDO8a+ME77e89L
	 IqpigoksJ1RLiPqki+ochQa3TEg0Onr+M2TyVEH6sdhZ8GiEFG5QLIkFW4JntFPCerA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485932;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=lhpIxR1TBcCZ6Tp+QskSkT6XixwZnSAQczofNbs1mFo=;
	b=eWojBUXPSKfLxJyHf58oRtVm/rXX26huZZleKhQXMUtWDYDe+bEO/eKjkQz1cuCbS+B/
	 vkP2OBNd7rNxuSDGmgrIztU6bc8pxmsYhtKBi+3hVyLnk5ctCDH08pS8REVRg60FRqUiV
	 CHhc69N/2+zUrT4sIoTHTajLjsuurSDBjJ14Qj9K2GCz3z8ncZssSMUf56HM3j8ZYSPDj
	 o6EZf3gHoAbCX1H7HhAsgk1KdX2P82vRGHLZ/8nFehaRYL++wXSSW37+BxxY+GSa83bj9
	 r4FYXC53q/jkpcjdikWYCUKrJC2vYTQWUJUo7uvIlhDWyqmIOnt700TOowslERMvgUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gOalHrKR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.56
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010056.outbound.protection.outlook.com [52.101.56.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B16606A31A
	for <sched-ext@lists.linux.dev>; Tue, 20 Oct 2026 08:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8B16606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gOalHrKR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/CfrXaqTXiQTSIu9ZdQXaxveInaohZRX0qvmsVPnOFGyEY424vzusXs12Eyqqbnz1mhpGz+B1aNM2DXMhKIFj+bR4ywSrFhcdfj3NaXzaQu4KVC2SCOu9c1AdUyQGrwx1k+/aAeJvVoiBpngA4ZWgK7MqT84fujobaOd92XnwMMwprG584MSFYyhBlWBeLOPg3FfPLyLBy2J63tEad3G5pFBXh+E7vw3Yt8qTEkymEQMSAqbebuSTtdeqBIanj749tnacrRwi+/TzDkRrC9TntW9IE7SmEPqY7NAmOGPVRzPp+UovY9IgNB5szrOTMbuIB6UKP+Cx3jqID/Wum9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhpIxR1TBcCZ6Tp+QskSkT6XixwZnSAQczofNbs1mFo=;
 b=Mv2QBOOAsza0uGaFk9mZYBatAcTVRixQ5OI/adx8u8ZsyUlS9lSbt2E9PnIMMWn//BLRr34eEjspiNGoVhlsLdTkSwsJBou3G1Ti8GbyEqEtOs5hdl6AKTxCkRHW4R4o5P51ckczon+DFUVHKYMuY8NgdSm52cyLlSTygJIGSh+3r3kn/YQZC6g24LYntNBKuIKV8LHo6+hVwa2cI4pM91YsivW84EcxNhhmf4BPY5ggJUniXycZCWqtVdhIs85psSNmKiy6cRoFF6cLN3qs0dPB0DX5k+dhz7eL4GKSUwjVqL0lN4uoiWsqajWNrqcqniMNbCt4ENj4KWy1vi8zCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhpIxR1TBcCZ6Tp+QskSkT6XixwZnSAQczofNbs1mFo=;
 b=gOalHrKRr0G5z0IpajpBkRl/ndYinnwKDzFPTpC8P8iTTWyC3GeMcU+SrL6mkN+taY5Y8cRlQX/BpQOgz+HZIZT8SWTN1ZIqDvAb9RbygpQ70wuZG60GH1b59topOUHBS9od6eYyVwgTwKv7FA/dXXSrq93ZYVufXWfFvaknFWQsmvARTO05m+j1N5oCV/WwV8efhNiQM7MYmHF0ogvZY0tzVZMmGe7U6xaZQy8x3s7S+f/uscb3+8A6xbAeWPGN24d1yy4ukeCsm2GLJria4dJX/1fbdtEeiA9U0Njc3lqjjce6I1j8Jyj/SYNrcXblMgD0IqS2G4RoeHeRY6cUxg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY8PR12MB7220.namprd12.prod.outlook.com (2603:10b6:930:58::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 20 Oct
 2026 08:45:28 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 08:45:28 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] sched_ext: Remove the foreign CPU check from the kick_sync wait
Date: Tue, 20 Oct 2026 10:43:21 +0200
Message-ID: <20261020084400.845842-4-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020084400.845842-1-arighi@nvidia.com>
References: <20261020084400.845842-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0071.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2a::22) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY8PR12MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ee56b97-5ccd-4b11-46d3-08df2e867dfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10067099003|18002099003|22082099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	xcg37ikXx2RnnewknDI7RbsA6UT09fak3CvomEvLjPHirIKh3ShyU1eLF3uRU8u5psTpp6oRVEC4kuR0pvbyjjb7ZbsA4Edf8ALYabaBe0lekeek2q1WwUQkkyLJl2/6ez4j6CHBOdnvLqxUgolTNFG5xJqRQKbk93Le1X91QaZOImB8jeabH4qQifsMPSHTKf9Scv5naBE/BxvThRHlnJ5AenccRGbfwBPidBjuqJT2qcUFGKPHIzsDDgWfv2nBmzsr+v24JSvFUIuGkF/Qh1crh5AytigCkKS8sSqHKQUYWBHxQfAUfdty1iMs5eQVibi/Qf0junXo2Kw6Sfd4r/z71dBfGK1us5qe7tm89oyt5f5/Z02HEnjmuKdcARy7gNCgo8Fc8yzQaOvf/V8m+S15EPFW7izN3d879wO1HjPIsFW7wLR85B04blEj/5zEmNJCcmiclVogsHbGO3uP71AXXEI2zbwG3EYU8h0LF9CpGiN6clm1yg/sPVWvqjoCeXzAQzijhbGG+Ivd8C2W1fgLY3W1JGqNgdHlGuwKT+nh3m5S8l5AjlzTWabMx3KxX4nwtqAom3p+zUWVRYQbJxWfhFChcN4jreYEBJSW9szItPs658aAqCyBL4LrS+5eFTEfLSsXdJr5NR6DgGueq9605tQJQN3xkpLKozJXmOw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(18002099003)(22082099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+onefcKaS1ro2vzMGWuRIAkE/8L7aBZ1k77E+wQcMHALvsEB7GgsqYiGAUbp?=
 =?us-ascii?Q?xSNl6N7uFcu0DIWzjpWKEiOqpsu7eDELK/AHnRP3BDvB+4zeEiJsXEEqV8OS?=
 =?us-ascii?Q?YPMTcp7RI4rz+PQAJKvzqlXenQLHLmdjWUxBGrdydJbSwKaIlwQxvmSO20jP?=
 =?us-ascii?Q?9m2mTMESvovHS4d+/tny9E9F7vVVy06m0bKryHnVkCJaRzqAF2SwxfAnAPJt?=
 =?us-ascii?Q?OmXrd+JdD2VrD+eEo9Me5yapNwE9Sy9YOaemKCdhfaMZglJsIuojW8OW9CjB?=
 =?us-ascii?Q?tVrvhMTpHXuYkiqY+DPxNbWvym/9/i4ZLEUXeHmabIR2a4gCDggkczIo7KVY?=
 =?us-ascii?Q?MzLLXmaesABI8OkU1ScesIV4BfkWdUFYA0H2ZifHbmLcU5uL2dQVGTSQT3eh?=
 =?us-ascii?Q?8hzDW+27+2bgqygTNgIaHzcYrEtQiObnfHpnArX59SjWvi87ORD6LQ6ZEUtj?=
 =?us-ascii?Q?eEJ+e1XwK1iYSvo/nzG6qRkW44urSL53alqjLbncg/Mcocys1fq5WibeqklO?=
 =?us-ascii?Q?wDH40DzFubEEYrGDUZxcqhkyHjWVpJnI6XZdwvcVThlwYDQmB4YcdjTlsLaB?=
 =?us-ascii?Q?GTsoI5xoicPI82pASzFXQ8cUVFVFIJuhvFEtrRy9i0crankJa1Pc0yVoiaKL?=
 =?us-ascii?Q?fYBx1i2PWUI2Ly0qIsAgNlXK1FR5TIju875ko/MLsV2CGytNI2b6q4OwTIhi?=
 =?us-ascii?Q?pWUEd9FeVmiEOp/2cH8qWOCt6OiLd+N5iCnJCFBtnvXgHpiKGz32Oxcza5gP?=
 =?us-ascii?Q?9sSUnLoKIKbjAekuP78B+poJMx7pxesz1jtF/nSjjvU0uilJJhl9nUG7IK/S?=
 =?us-ascii?Q?bEbJxHVDYZAhFnY7t0dHwmqmQia9V2m8N5l86hLlR6+l9q/XpThuJAxwFJ41?=
 =?us-ascii?Q?wsM7k0jELo+qojx9qw2Br3enrBTU8TKAJBd0dkEM+gHVdTx77l25QjcMkMPV?=
 =?us-ascii?Q?WEVcWORiMT5koRDzEXtK12heqx9uO1Tm5D6t/jaX8z/azR5AxhJiinglNp2p?=
 =?us-ascii?Q?wlAJ9EMIb/hZW4axM/eIFwmcPNm3ZKttJeGayonMu9P6eGDOhAAyKy7OPGI6?=
 =?us-ascii?Q?S9Zrr6hKIW55vEIWQi7MqYlrk998/SAzB+4i+AZ87UZzPpt2N+DWBPIVhl9V?=
 =?us-ascii?Q?FAfCWD9iEMbv/Yq+Oq1X4y4LLh7ZGR90hsvNf82e533Ll0rhmbFjnbSoRwVr?=
 =?us-ascii?Q?Oiw7A1wYBiwnkRz02TUHlaHZRaB3Ve7nu9DvoKfeAHBAIAiW6NSvzs4fILFg?=
 =?us-ascii?Q?gRLkcRvFK1Umd/p716QCw0WsR2sb88wwaLBMKgBDWOlqwzcIF+aPhLPfNLon?=
 =?us-ascii?Q?1B3tv4QpOYRJJwDqur9Hrnj8YfjgVm1z2EPpSSFKL2Mb823ahnjFZzgbHG2P?=
 =?us-ascii?Q?DkZ43J3ZXf/Z47Yd0Whoq8vNWMhZVUC2pDeSjsTY4UpxF1YhGV/7IIyxA/Ix?=
 =?us-ascii?Q?05Nnk1H0NRqTNWU6oSrgpK/O70+KwcbcNmckvwKD5mF9CB+0d2uPXFcYJftJ?=
 =?us-ascii?Q?rYPo0XvUY009SVO5+BCgjkiLZJbl+RR4h9CQfQtbqrJjgFOK/GRmcUtWQ9wo?=
 =?us-ascii?Q?vQQ+xt9JpnVW7WbUYLahOokXwO0PenQ3Qf9owadTQaTwZsVL5ZDRx+zdhYkx?=
 =?us-ascii?Q?jmNyNKYjCbjUEJN9n9m9BOuS1tJJ86q/NGDH3e/QuVIya09GPfctH54glb3g?=
 =?us-ascii?Q?625JjdfFmn2pAxK+CoygT4Hc4e6sGKWQtVDiH3DGLE8I4D8/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee56b97-5ccd-4b11-46d3-08df2e867dfb
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 08:45:28.4673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pT2SYqHtIjL0auMO/71IscKpLvDWDAZvblIJWFU05WWkaJ3ST9hPpV/K2NLSrPgahtsU2zbXHxZ/szlA5+AOMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7220

The kick_sync balance callback is now queued from set_next_task_scx()
after the core-wide selection has finished. Proxy resolution zaps the
callbacks before dropping the rq lock, so a foreign CPU cannot acquire
the lock and flush this callback while it is queued.

Remove the unreachable foreign CPU check and its obsolete comment.

Suggested-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/08cac02c604dd73ef96fc92eb29d692b@kernel.org
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext/ext.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 4b7d2602b4d40..a9b26fa431bf3 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3733,15 +3733,6 @@ static void kick_sync_wait_bal_cb(struct rq *rq)
 	bool waited;
 	s32 cpu;
 
-	/*
-	 * This callback is queued once the pick is final and flushed within
-	 * @rq's own scheduling pass. If a lock taker on a foreign CPU ever
-	 * flushes it, the snapshots are unrelated to that CPU. Don't get in the
-	 * way and leave the wait pending for @rq's next pick.
-	 */
-	if (unlikely(cpu_of(rq) != smp_processor_id()))
-		return;
-
 	/*
 	 * Clear only when the wait actually runs. The callback can be dropped
 	 * without running (e.g., proxy exec zaps the balance callbacks and
-- 
2.56.0

