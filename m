Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793074688;
	b=BcOzWyBhT61NpzTce6dFy3U4WR+4eSbjrqbA7+L5njI4i2O7ZnnfS421OyK/G4dNOuVP
	 EWK73kmnCD1WOKwiViSbCC59kTqKJRwZBnxisD/d3f5bCEGLameNdidwQIorNAIUtNqCW
	 lgYhXrxplst/6qBhd/pHdj0Z+jCSYSw6wOmwBzsGp9pP7TtvwC8kNRwgUAN8//h0WXJg9
	 xFvHfbxed+3XSv8MjtLXcy7tGL/0hTB+iou1bSTQwZIMCqHvrTWGaqSVBOLkaqV7eQqqN
	 0ITxBN1Zz4vUM3yy2FvR22q4KI2By/VmXQgUwSnccee0LT119mEuEtcN1B4cOqdn/kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793074688;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=72Y5wYbb/pCu2J+PZKt3JtJZDPmX+zwKOmZdjmROo+E=;
	b=yQvoL67giKLi54kgneWh722Fur3IMlBscBHYB8F1bbSdUmqNV+KcopV1aSGr6KSbrWGv
	 nBl24qarwgq+nSjcbD/UR7YWo/D4MIU4X/hNkAtNAeCFekHf0WkReTKQ0n9x9hZcNG/+5
	 k0+uedzLXxNSKClb6x+v7ISBdjWgGwnAYOXEfcEmgP5XlIK8xJzkjKBP4SQUzcI8tS2Rw
	 FfEhghxHUVN3nbS8HB/n9n5H5Nl3BiHnvnHoxbZ55XrthUsTANjpXJRHmZeN9gENPwgCg
	 Fm/bAxg1iO/UbAi4VSAlAFHjjFY3s36NjJKJ/FkBskv3fks+VNoe5NSYEAqz4YLREIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IxST1igC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.25
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC186606A31A
	for <sched-ext@lists.linux.dev>; Tue, 27 Oct 2026 04:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC186606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IxST1igC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8dsD9YfbsteW/buKxCTrqb+Abih2GQm2iSDD5yue03oSbAZ6CqNWD0QD8A6OvO5Ad5qNfYx0jXB7uJh/2bmGwqKiiRbhHrH1ya/9+JOGAQ9FTBfAZfLrugsdd5Aoox2y+tOrJ8PrXQRGUoOFb2BhWDrCuFImXG2tPyHivY2P+U9yTcaqgOHT3mV2STm1YjK6+xDjrK6FmwM+luHdyqBX1/6LAgNiEh/5LeXIhLLwy8IZ0oxg38/KBwCy1uAdrftMktOJY2XMJLZe7Q7+1ILeVWgjAF/6uYqOqVH67dcSFMYWUGWLqa4MemJ4k3tugWVqPPTwjcIKuTutek0wa/cxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72Y5wYbb/pCu2J+PZKt3JtJZDPmX+zwKOmZdjmROo+E=;
 b=soiiw20Mw4tnCSM0RA554nKHMiFBXzi4JFsoG3k3ym2SU1f5tyuYd4P653oEKv7tj10miO/TyH5TrjRoh7kG1OP6nRBE3GD/bqrdRAmnYyBkC9IBfJ87uqF0j/b81/1QFPpkH/i+EHVrZKOq+MtVU5prtYPmTXvglXUm09XKHk+l1lAR+Rp/LnrTyjz5GWXmn8hv8+592KwdjDm2PzLiR7w4OWWhbILoymXzBapD7aSxM/p23+h+k3zvlxW2s8jahexB1NJSipZ9ExmLBQm8OOK//B2NM2YHvylX6gloMdU3e9DTSi9H4NbSgq+eLdO0+MayKcaZz/1HdMC0OK4/2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72Y5wYbb/pCu2J+PZKt3JtJZDPmX+zwKOmZdjmROo+E=;
 b=IxST1igCBuY1kAJVozpKD/gFoL8Thj7poTQU/Yq6BSR5Uia0Gsm5f94ucIxNamqI0n61sg+lGvjxzt1xbDRpAupSNiDg/pk8L0JF95lwTcrsNzmkFhAjNtxum9d7Pb16QicHK0IrDzsof5HyMkzBpZToC/zRYSt16hzSskY2j+6sHBMaQf1/UlDmWpnbUq0vbXxbU+Sb/cMuRTDYsLN9MVUsI67jgv5hmKMtiJICLasEhv2Twq4R5xW4Pd0broI2OVoG6ctkuJGJl/ROGztanOVlYeizFof86Gpq6FO8ctfXEWfY4fR14EDA+QjmcO12cWdfxuU+YXJW3EjDMfJTQQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY0PR12MB825472.namprd12.prod.outlook.com (2603:10b6:930:130::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 04:15:46 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 04:15:45 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Vladimir Vdovin <deliran@verdict.gg>,
	Gregory Price <gourry@gourry.net>,
	David Dai <david.dai@linux.dev>,
	Emil Tsalapatis <etsal@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Lee Trager <ltrager@nvidia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v2 sched_ext/for-7.5] sched_ext: Add NUMA balancing support
Date: Tue, 27 Oct 2026 05:13:29 +0100
Message-ID: <20261027041536.3317971-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0303.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::16) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY0PR12MB825472:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc50198-b0eb-406f-e83d-08df33e0f92f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261009223027099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|10067099003|56012099006|261026121527099003|6133799003|18002099003|5023799004|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	N7pk5nUm3tTIC9b90OpqXxGDO5TcGzAvl2lN6V9mty7miteqGQxEDn40x14cSXIfS0dj8T2T0+brfRh1M+GXxC53b8iX1eqhwknlH8EsdNhZoSXZ3rWWUsZiAPyuO9ssiFuz7eZOjpRG2LMYXK6w9xCv0uJTr8rY12YtaArvn9+ZZFmDwgLEjnraCpE1aqPqJtrrgv5WOCib3dz6/pfeFWkyumInmpe6CVXsJluaFOmWl1fFIvhEsLutjpHNc6rwK6stRNZkY/DXioyud+1/VyVi+xNPAQ55yQQs/DaAscWt6xgNmFKDa2iLN4u6OWuOCKhUG2nIUa2EEMvnGKmR+bFpzJ7de8D9Ohf5ViL7abuiqT6YMdFKDBLIH2Ynb8OLtLv1PGq3xd/E+5sZGDDyU9UpRo4mnATP+Mmy6Z45wM0e5FjNzkmVoUDUliyYTvJdrYxP4ldeioi3jVNv3QMsrloofweq0ny6ip/vJyTIsjDuwmZvuhTMU2sEC24abbxoZCs+thIS9xlKZ4b6AXK0k+W4wx+n9yvEem2VaE3821std76++9PqjWTGVzuJzfUQdbTxtg1VpNZvB/rZlFarElAkpuYvoxLruPjc4tRt2vV8ALyrz3pharNwz6PA6YxNmSsFfmDVL6LYsAAdeydSG0FIvXtcJ2mHuEZCT312W1I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261009223027099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(10067099003)(56012099006)(261026121527099003)(6133799003)(18002099003)(5023799004)(11063799006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iUo7AJCbHSiKlpZAJVa/K+AJPvI6nidT3bqmJ2ESU6dKq3HEXCpKOmdvBehe?=
 =?us-ascii?Q?3nB1uxfkttGrA3tfgqJ195H3zzbfUVdF7E7tXzh5Xa5qkoYxjZFLJnFa6DZW?=
 =?us-ascii?Q?cCrpbDWzR8c/evniCVBcCV2Msm9sPzi0yDucfhG3Qrgyf2jX6fJnmi46BNXr?=
 =?us-ascii?Q?JA2/GhFN1M/DhriOYPO3xX8KWUSEOc0bM9Bglf+MFGlN82AnKvMShHFy8uaA?=
 =?us-ascii?Q?9xg+8vQq2f3HV27GtXcOrEZcJOcq/JzRJbOmMYqDHdTh8XkB2sBOXj6wXkNT?=
 =?us-ascii?Q?zPEny0pFm0uZ7VqUIDCugbUCSjaIEw63Iv7r4zZ1KgfA99h3vOcJkNUnOFB6?=
 =?us-ascii?Q?Jlq8we6UOU035KPvK6FfwdlPG4AbuElGCGJ3pNE4uM8m3pBJwjLiLMdEpbOB?=
 =?us-ascii?Q?e57j7MkqsaP1drekinkBAX7BBaZAPOomQOYxtigL40o0avcHJay0Sy4amUWK?=
 =?us-ascii?Q?8+B5FmlRIYQX2ag+4W7BwKe4Esn6D9azNEreq3HYcUF/2sD0I+LpMiZmX2RX?=
 =?us-ascii?Q?CHIZwMMOOOF2kzIOl6QtIKwfNF+OQbckBhu5epsG1hdhJ+gOZKdxyNalB5HE?=
 =?us-ascii?Q?Ro50Wbxx3wou/f8FAKlTclJNb3196BYXifVg5Z8yH0dA9I6qI5Cx9lKiNScQ?=
 =?us-ascii?Q?uy4Vulhjczy7xp3k9ZJtrISd+qHcMkRwLYYa2tkStZvQphEmcpw+OF9+Lguu?=
 =?us-ascii?Q?GVpW5yMVMz0tr8EaWnn/kFi0AneOquRsy263h4zypDBEbOzY2NAA47Dn025y?=
 =?us-ascii?Q?RuzUA5whhArnewdi8H1g31pv8FgcRuXb+nLc0nlPkW4z4zPQV2OXQ8p1YuNh?=
 =?us-ascii?Q?saZsZqkzFX31jvG+uroy97+Y9dKeuU8JQy3lynKX758Qr8Zrc/SfLMc4roo2?=
 =?us-ascii?Q?Y8bkIobVvPErN4Or6UJeHO8Ieot0Itt5DdT4A213zb4sgZsZAZxi1eJcRCdU?=
 =?us-ascii?Q?L3/k8QWxBZtJz+5GnDWX/yfF7XZ8E3XPnSozkNvBCZRafYgAS/saSGroQvYi?=
 =?us-ascii?Q?lp0ameTwrs94s9VMMIGNcxSdgIcx/f7f2fFji2/UA1thixVaOuzXsEPMT4mk?=
 =?us-ascii?Q?wIme/MwqCCqEGf5I8/zKnNl0baNVPL4Qt12bUGRERUAIJiuuedmZVUZX4lJY?=
 =?us-ascii?Q?0/xDGhfvTW/70Jvoz5TGuHF7U2v2pg82QabPRn62htmjV3uFPVXpEWz64lEe?=
 =?us-ascii?Q?CdZSG9Aog2EW3BGEmszNM1DJWwcGNI+YJ0Z/0fm1YqVtbwccA1isTS8IjUaV?=
 =?us-ascii?Q?k+Y9ZwL7tLUs5nYfn1jHpC/VWYu7CET5NZHbyoAh15gVVhotCOENXa60GSlY?=
 =?us-ascii?Q?iJLdNYJ2vnkXzXc0afjOM2+AeCOw2RFgz6VrVviaM7Yb9gQqt6REzHL+8Hr9?=
 =?us-ascii?Q?Bs4A4hGE4/4+4CxcqBP3driZT5ZIGSFrCdMQeJYV74i5jfxAwo7KTmh8EEEM?=
 =?us-ascii?Q?c2T3sfLBQh3qdSQlYetXOTq2YClyZzPBJYQ0+QwmjFXYiim1XGseZ8mh7hGC?=
 =?us-ascii?Q?K0E9KM/d1FjgEK8ggPBD+Y2BDJH//DuQKOb3ywnBl5/EPELD8qwmhCq/QHG8?=
 =?us-ascii?Q?EPr2qAe+2RHGFyw6XkpVtaVkEVfAW0TQTv5v7QoTUHfP8gx0AimrEtA15m6X?=
 =?us-ascii?Q?TWeuk+OoitfsGUvlRsbJLfNECgfVbP+nXp9Px6eGWcFQY9W0geTW3GZKSxln?=
 =?us-ascii?Q?mxvozCe2EK9ybDM1B7uWS9+qWjCvDtuBco6S1xchrJHMlaKL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc50198-b0eb-406f-e83d-08df33e0f92f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 04:15:45.7507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSfsl3vsixWtFGtUo3JZbYm7ltdG9mqx0VkRmKucZ//PLGxkojWR00MO3atVT2MU4Hyr49mc7hXrLRT4t/wH5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY0PR12MB825472

Tasks running under a BPF scheduler are currently invisible to NUMA
balancing: their address space is never scanned for hinting faults, so
they never record NUMA fault statistics and never acquire a preferred
node. A BPF scheduler therefore has no information about where a task's
memory is when deciding where to run it.

This series lets a BPF scheduler opt into the NUMA hinting-fault scan by
implementing a new callback, ops.set_numa_node(). The existing scan is
driven from the sched_ext tick for the tasks of such a scheduler, and
the hinting faults then work for them as they do for fair tasks: the
kernel maintains their NUMA fault statistics and preferred node, and
migrates the memory a task accesses toward the node it runs on. The
tasks themselves are not migrated: their placement is left to the BPF
scheduler.

ops.set_numa_node() reports the task's preferred node: once after
ops.enable(), as ops.set_weight() does for the weight, and then every
time the preference changes. Changes are reported from sched_setnuma(),
under the task's rq lock and before the task is re-enqueued, so the
scheduler can update its placement state before ops.enqueue() sees the
task.

To keep sched core free of class-specific code, sched_setnuma() notifies
the task's class through a new optional sched_class->numa_node_changed()
method, which only sched_ext implements at the moment.

scx_bpf_task_numa_nid() lets a scheduler read the current preference
from any of its other callbacks. For a task on a BPF scheduler that
doesn't implement ops.set_numa_node() it returns NUMA_NO_NODE, as such a
task isn't scanned and its preference would be left over from its
previous scheduling class. The value is advisory; nothing in the kernel
acts on it for these tasks.

Ideally the ultimate goal is to give BPF schedulers both controls that
NUMA balancing combines: moving a task to the node where its memory is
and moving the memory a task uses to the node where the task runs. This
series provides the first: with the preferred node available, a
scheduler can decide where to run the task. A second series, to follow
once this one lands, will provide the second: a kfunc that lets a
scheduler request the node a task's memory should migrate to.

Vladimir Vdovin recently posted an RFC [1] that drives the scan from the
sched_ext tick in the same way and skips the fair-class task migration
for tasks under a BPF scheduler. This series covers what that RFC
proposed and adds the callback and the kfunc on top.

This topic was also discussed at the sched_ext microconference at LPC
2026 [2], in the context of placing accelerator workloads close to their
devices and memory.

Patches 1 and 2 are small preparatory changes to the generic NUMA
balancing code: the first makes the scan available to other scheduling
classes, the second skips the fair-class task migration for tasks owned
by a BPF scheduler and never picks them as swap partners of a migrating
fair task. Patch 3 adds the sched_class method. Apart from that swap
exclusion, which only matters when fair and BPF-scheduled tasks share
CPUs (scx partial mode enabled), none of them changes the behavior of
fair, RT or deadline tasks. Patch 4 adds ops.set_numa_node() and drives
the scan for the schedulers that implement it. Patch 5 adds
scx_bpf_task_numa_nid(), which lets a BPF scheduler read a task's
preferred node from any of its callbacks and returns NUMA_NO_NODE for
the tasks of a scheduler that doesn't implement ops.set_numa_node().
Patch 6 adds a selftest.

Changes in v2:
 - Replace the SCX_OPS_NUMA_BALANCING flag with the ops.set_numa_node()
   callback, which reports preferred node changes as events and enables the
   hinting-fault scan when it is implemented (Tejun Heo)
 - Keep driving the scan from the donor under proxy execution, consistent with
   task_tick_fair() (Vladimir Vdovin)
 - Never pick a task owned by a BPF scheduler as the swap partner of a
   fair task migrated by NUMA balancing
 - Return NUMA_NO_NODE from scx_bpf_task_numa_nid() for tasks whose scheduler
   doesn't implement ops.set_numa_node()
 - Extend the selftest to check that every enabled task gets an initial
   notification before it runs, that changes are reported without duplicates
   and that the notifications agree with scx_bpf_task_numa_nid(), and require
   a preferred node change on a machine with NUMA balancing enabled
 - Link to v1:
   https://lore.kernel.org/r/20261004072901.3579967-1-arighi@nvidia.com

[1] https://lore.kernel.org/r/20261002124559.10367-1-deliran@verdict.gg
[2] https://lpc.events/event/20/sessions/270/

Git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git scx-numa-preferred-node

Andrea Righi (6):
  sched/numa: Let other scheduling classes drive NUMA scanning
  sched/numa: Leave the placement of a BPF-scheduled task to its
    scheduler
  sched/numa: Notify the scheduling class of preferred node changes
  sched_ext: Report preferred NUMA nodes through ops.set_numa_node()
  sched_ext: Add a kfunc to read a task's preferred NUMA node
  selftests/sched_ext: Test preferred NUMA node notifications

 kernel/sched/core.c                           |   7 +-
 kernel/sched/ext/ext.c                        |  88 +++++++
 kernel/sched/ext/internal.h                   |  20 ++
 kernel/sched/fair.c                           |  21 +-
 kernel/sched/sched.h                          |  12 +
 tools/sched_ext/include/scx/compat.bpf.h      |  10 +
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/numa_nid.bpf.c        | 142 +++++++++++
 tools/testing/selftests/sched_ext/numa_nid.c  | 233 ++++++++++++++++++
 9 files changed, 527 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/numa_nid.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/numa_nid.c
