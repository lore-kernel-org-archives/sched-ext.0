Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9D33B8922
	for <sched-ext@lists.linux.dev>; Tue, 14 Jul 2026 07:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784013030; cv=fail; b=pNHYR5YYZaGdtF8pBlWJqcrcP+7jPrFm+psdfA7i+tsDUQO0FdmSmEDJAl+4IxCa8aPJLYabF2SLGuVmHl4Luw708pyYubNflTIN+c/uTXv3ezolpYTBxSVL3Q5NXDOULI4Y+NDbSHLPeZRnXivHazMx9Sf+KpCtXFUDwULgm3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784013030; c=relaxed/simple;
	bh=UrIS8i5kgOLe4YEnE1nN6wb/uLuY6AVmZeKTKaa6eZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A48TZ3sQGRnL8JZ0ElNDS+Hu5gzNR3h+GL1/F8m1meidKzmkkKflc6skXOMcMQIodEgYTOkgawoZz8g5bDhHfGE05AgaNCbHcO/m+Ji18RkfqzF7Z11k9tN49/uszxUIyW4ATdQZu4zTq+xH/6BiyT68VlKljyOxVjshbVsNzzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IDjDiptG; arc=fail smtp.client-ip=52.101.52.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IDjDiptG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGZw2RCPW7/CakVS6XWVhtaSgkpqJiVFKHX2PhwQN0EcRZ0w+brFq6EYs6jFnMrMvWZM5G7h/8yHfs135ZAn3W7YmM4ctvWBeZyB8MlX1DcBBs1AYcveaMLT00Ida6VT/vlMIucV/KJk/Ute0W3uw7G/FrMYHi9AoqwMAdyNvMCsGd0PCvbNerKvr79pUTifTzFBtFu+WWOQMDtz0iejGeO7e33lzdNuNCXuwBZMxRrhiLdMzoXqAe8vPTfzfcp+mBMRemWd3Ha0scgEj+dIm6Ci2n4nNhgojtEVISQz1j55DOUghrNVrIWFQ3n6kRih8o9U402y/9TdDDszo/mYUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOZNvNGlsyKCOcBWlrqYFUMgBTU3MaYmSgOSus+OTzU=;
 b=sTbUcRpAajb0qtF+HPZYYMDbFTTMrwQSjYnFGOAIuW9KbKcJ3erfL/UZbMix9gWOHkrfguvirmitDk7Et0ByLYazixyt4ypB4xTS3Tgdun0wAJO9wV08RJ/Y6hzji3fyfbEoq1sazSrM1mEvbrbcMdDBJoo+kt7R1+An60zsbCp4PlUfXJaGX4f5URuHbnqyYjoagcvdR8qnfOZf4LqIiAzVRdAVDBy1UtQDLapxl8fkui2nGKfzTCylE79w/d83IBtDH0n9Dk4Cy6PHXVt18ZvN0Nrh/D4JCCizy2sFSAdkgcJ3Wq5X3uYzzIMLZHNvLE8s8jIsbi6hsJvX80NB+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOZNvNGlsyKCOcBWlrqYFUMgBTU3MaYmSgOSus+OTzU=;
 b=IDjDiptGfsOvUMJxNW7m+wMDEgaWXr6TW3s5WUCEsVCNtwq+/2mFHX5UFBiIiJQ4vTpdc3PYKMYi1CNCg6i4xXpsdGKYT6F0UtFBH0K0nYKijlaqEqADBCZpUidnwCxz3ph91W33RJtQPi4U/n1y3RvtZ1Qb67/gC3I4zBs2ZBZoDlLwg4e9nAQodUeQE/0mJJYz/m9g07iVwA8ULipRz+MCLCs0ZAV1nGZXZ7CTttrc9ec4e6HvI1tGiZO8RzuSFPI+ucikSf6zSSXBGzdkWScDsSt4RDiR2htyCDy5OcWhWcNOrJHS/mlp8WIcRQ+/ocVp0Fo49fvCPiZVom/QJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SA0PR12MB7479.namprd12.prod.outlook.com (2603:10b6:806:24b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 07:10:24 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 07:10:24 +0000
Date: Tue, 14 Jul 2026 09:10:13 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v5 sched_ext/for-7.3] sched_ext: Capability-based CPU
 delegation for sub-schedulers
Message-ID: <alXg1Ux83csDVjKf@gpd4>
References: <20260709225041.1695495-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709225041.1695495-1-tj@kernel.org>
X-ClientProxiedBy: ZR2P278CA0006.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::12) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SA0PR12MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: b5034bfa-ad29-4efe-6b0a-08dee176f98a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|56012099006|5023799004|11063799006|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	bvc8toeTS0+4n7ohrSKyuBmMf5IAqaXHQ7voFK3skYreIgWUSxhtw/XMQ3Na9Q4S2H/Uwc1Y3HT82se57Cmk7Xh1UHTG33ARnJQhyGKdmgRizISZfdc5ZnM41V5uP1NZA/FkJ8lI7spENcFXzozU1yknpz8gWawO7b2YgihPGylJCKXLwZRQXU7iSgRa+Ho4KZIi+sUns7dL9Y9T5PK6fpL9hM5lYJp1bxtUjDJnrYipbtE5BtwVeWg0NFzrP06SfUqoJPGPFlPLXKRSvFOvqBa2ed1bOwDA9brieaH4pXiwsVPhAWoXdQUqrNWh0AGxJzcrlMnCQhP/VfiJYk7Z78Yxt+en6IMoX6y3bzaHtn3mwroWV1Jy90ERboIZ5pryPPgRB2fNUn/WUOG8D8S651y/8te7EGMpr/u2KPv6vGSI7oGVM7QTwn2NukpZd/gggB/x+C7WnGkPawFQTSWEcChl99tUjFm7nJmIGGQkph6VivoxQzC+zOGrmxyLI04u/xMo5MaBLg8qxCYCayg5EpkAKnBIVIEVaLVfMkH0uNMvhQNr2DpV89HZ5ezLaKSeCQu6lavz30drNN1YslIucJei6tUJXuyFBHnyrfvsU3pzLquxJLmsTh2ukZ22DG5j0IWnLpzkkiZBbvdErfCBGYJuhFs0/CCv7iYUqyerlX0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(5023799004)(11063799006)(6133799003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WYfL7G4XTN5AB7uC+C4wH328IJDyqGiUTmwC2+rYGkcInvd0oTYjotZr+54C?=
 =?us-ascii?Q?pJKD6FVqWCavzv6RGKX8rn1OU/dr69qVG238yCnpd/VwID0+TYy9kZ2HwSm7?=
 =?us-ascii?Q?OrV5cKPpx1NVJSY/lpzVUDRHKrtYLOxcAFJe4y0glhY8n8FhpjM3WwyET5PM?=
 =?us-ascii?Q?xwHUFmBvcPxBGnxtIlmDwysPKJs0jWj3Aob0rrmCZx2kg3adi9riZLUknGsO?=
 =?us-ascii?Q?cX1Nho/L1/Y2/UfRCPJVyhOo0j3CmFIEbRUWr0obntUhMxwZWoM2elMUW7Up?=
 =?us-ascii?Q?y2nLoPTPM8ulVyj7wNq881TwBX1qdHhzssVavlqdYXVJ8QFxzcaw3d0AieLq?=
 =?us-ascii?Q?9C2UPq+eDOYexVvTDf/iXTGLylsPvbuB4etHivgYrUjmTAYx0VtKmRhcO9+l?=
 =?us-ascii?Q?ccxN3/NJ6umhajlBoURg8LIk1dzbxCGQrwZD2w0AgXL55fQYFs8bZVqQLzn7?=
 =?us-ascii?Q?2j2fZyH0kt4wuc/RJkBAUfnQaBKTZtVyIKiCQ7kh2VlUyj441jk6RdC5BL0p?=
 =?us-ascii?Q?Iu0/JIyRmHPqiIhB+Wa2snO0ls7ihlSmQaSXP55JVQy6/jlplN59tFTs/7hK?=
 =?us-ascii?Q?WmilcGkkwfMtCTB+GK1wJ2d3qFVK6ElK++SPiTbAcLt/eWUfv2TT9xHiPGby?=
 =?us-ascii?Q?fdeufj5THUQXSsrACOuZXADOPbQNtBhyI1yVIc6mMwz3E+6SZoOoAGo/w9cz?=
 =?us-ascii?Q?1Z6yREptM7cJMr1XqSE0zKh/fpDuicmaXMuL+LyzBXUwOQtsL2D54MivLydL?=
 =?us-ascii?Q?Ni4Asa1AvV2wvaMMTCwBvnhEdPOyBPzByV3lMLgpJa5XTFcWA8+PZIxIIY5r?=
 =?us-ascii?Q?OiCykH5VZv4XMRd0p2jQ/AB6G7lUbuyg0aV9WQUA1c0FJZ6Dqcb+tTe2rx+3?=
 =?us-ascii?Q?ZLc+rrApKJTGH5A6MhZRZdZBemRVspSiYWUmDdlokslrRuJFesYX8G6lijX8?=
 =?us-ascii?Q?2JinWNFUOfHyuUkb0yzO6lfx1GHt/R62yFVpObr3Vhd7t86GwdCVWn1tlyDk?=
 =?us-ascii?Q?4phfH3TbgQ0UgMrz2jAjTXA3Nz74d85tZ5iabobMscabUdYnwJzjDZA753nN?=
 =?us-ascii?Q?iBuEuiRuTv6I5iIY0+mgaw4lD/PtPZFbJqemmquVT/QomM5g4cGKx1sb5N0N?=
 =?us-ascii?Q?UXHhsy+eY3P4Q+4ydy6eN9lMeOoyhvXtql+96z90q0GfpKyacqwqKCnUW0nF?=
 =?us-ascii?Q?CYsUzx7MnOoq2RwM4Jy/Qip10bXwifKhPwR0JrQu2wChbU1Qj53KWxfUg0Qk?=
 =?us-ascii?Q?P56qa6osqMElsbqQVaAL4sVLUsNIRls2wcBDm73mMKSVEIuIfWw55LcjEmJ5?=
 =?us-ascii?Q?tulcW2p0Tl4hGxnJ3BzYOPThCtp0c6iGpyyaxfqOMLU0vx97EkXlCfKT+r8q?=
 =?us-ascii?Q?CtgQKLiFxdKjgwcunEUICNcfpOBV10+/S9tqHsiwBc96RhiH9a/5Kr+bEdg+?=
 =?us-ascii?Q?0lz1uvy5qFRG0kCgzYJfy0jeVbqHu9VGvIoSIeB/fqOD6oXFvWxR6YpTE7wT?=
 =?us-ascii?Q?udAHRmhrReUTr5eal1t2c4PzO1X8tScgWXcXDmAKzIohTQM4443bA18H/zg6?=
 =?us-ascii?Q?NgvgJCzgQJ41FDh8FHyJJ5NA71JDET1nZztm3l3dYVv5HQzA7lXlN4jcA82M?=
 =?us-ascii?Q?EiZlBi9oFs56eCoP6YdI4DtDo11wY/s4tEvu4QeRlWpI8kM2G/vsGpJDuyW3?=
 =?us-ascii?Q?iWIChi4P1ZRFKQK8MxUryNIKPYHPcZuTtGndpm/xKzYG5T7r+c1/TD+pY6EL?=
 =?us-ascii?Q?VLHtYoaz7g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5034bfa-ad29-4efe-6b0a-08dee176f98a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 07:10:24.5255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPsuzbRIykTFLyoTTJy0kn6Eog46bIrRD0Ihv2UJOGSqzcHtABdblfKuS0rqQ3bcWV8P/JtCZY0QOdmfVB45rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7479

Hi Tejun,

On Thu, Jul 09, 2026 at 12:50:08PM -1000, Tejun Heo wrote:
> Hello,
> 
> Changes in v5:

I went through the series and tested the resulting kernel under virtme-ng. I
couldn't trigger any crashes, lockups, or warnings, and I don't see any issues
that should block applying this.

As I mentioned, one possible follow-up optimization would be to introduce a
"scx_has_sub_scheds" static key, indicating whether any sub-scheduler is
attached. This could preserve the current fast paths for the common case of a
single root-only scheduler, avoiding the small potential overhead of
sub-scheduler-specific hierarchy walks and capability checks. And it could also
enable additional optimizations in the future.

For the series:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> - Patches 1-9 of v4 were applied to sched_ext/for-7.2-fixes and
>   sched_ext/for-7.3 and are dropped. The series is rebased onto the
>   updated for-7.3.
> 
> - New patch (01): WARN when a per-task op is dispatched on a scheduler
>   other than the task's owner, with the two intentional non-owner call
>   sites dispatching explicitly. Hardening out of the v4 placer-vs-owner
>   review discussion. (sashiko AI)
> 
> - New prep patch (19): an in-place SAVE/RESTORE requeue of a running task
>   re-ran cid admission and could bounce a task to the reject DSQ under a
>   scheduler holding only SCX_CAP_ENQ_IMMED. Mark such enqueues with an
>   internal IGNORE_CAPS flag which requires no caps. (sashiko AI)
> 
> - The CONFIG_EXT_SUB_SCHED=n scx_prog_sched() stub now also refuses a
>   dead root scheduler, matching the =y behavior (12). (sashiko AI)
> 
> - scx_qmap: mask the highpri dispatch pick with the node's own cids and
>   read the sub cgroup_id once in the dispatch path (32). (sashiko AI)
> 
> v4: https://lore.kernel.org/r/20260708212429.3405787-1-tj@kernel.org
> v3: https://lore.kernel.org/r/20260707001229.1410929-1-tj@kernel.org
> v2: https://lore.kernel.org/r/20260706014058.439853-1-tj@kernel.org
> v1: https://lore.kernel.org/r/20260703080159.2314350-1-tj@kernel.org
> 
> The existing sub-scheduler support only covers a part of scheduling. An
> scx_sched can attach to a cgroup subtree under another scx_sched and detach,
> and the dispatch path has programmatic delegation: dispatch runs as top-down
> recursion via scx_bpf_sub_dispatch(), so a parent decides when a child gets
> to pick tasks for the local cpu by calling into it.
> 
> The enqueue path is not implemented yet. Every scheduler in the hierarchy
> can insert into every local DSQ, so a parent has no way to partition CPUs
> among its children or protect its own share from them.
> 
> This patchset adds that control. Most importantly it enables sub-sched
> support on the enqueue path, and it extends the same control to the other
> paths that touch cpu access: occupancy, kicks and preemption, and idle
> reporting.
> 
> The enqueue path cannot use the dispatch path's programmatic model.
> Dispatch is top-down and the delegation is implicit in the call chain.
> Enqueue starts at the other end: a leaf picks a cid for a task, and which
> cids it may use is the cumulative result of its ancestors' delegation
> decisions. Resolving that programmatically on every enqueue would mean a
> cross-sched round-trip call chain, possibly retrying when a request
> cannot be granted as-is. Delegation is therefore state, not calls:
> 
> - Ownership is tracked per (scheduler, cid) as a set of capabilities:
> 
>   - SCX_CAP_ENQ_IMMED: insert an IMMED task onto the cid's local DSQ.
>     This is the baseline cap (SCX_CAP_BASE) required to make any use of
>     a cpu.
> 
>   - SCX_CAP_ENQ: insert any task onto the cid's local DSQ.
> 
>   - SCX_CAP_PREEMPT: preempt a task outside the scheduler's own subtree.
> 
>   Higher caps imply the lower ones for the holder's own use.
> 
> - The root owns every cap on every cid. A parent delegates caps to a
>   child with scx_bpf_sub_grant() and takes them back with
>   scx_bpf_sub_revoke(). A child's cap set is always a subset of its
>   parent's.
> 
> - The cap state is sharded. The cid space is split into topology-aligned
>   shards, and each scheduler tracks its caps in per-shard cmasks with a
>   per-shard lock. Operations are broken up on shard boundaries and different
>   shards never contend. Shards are expected to serve as the locality unit
>   when cids are handed out to schedulers, so lock granularity scales
>   naturally with the allocation pattern.
> 
> - Hot paths check a per-cpu effective-caps copy with a single read.
>   Grant/revoke rings a per-cpu doorbell and the owning cpu folds the new
>   config in at the top of balance(). Cross-sched communication happens only
>   when the delegation set changes.
> 
> Enforcement:
> 
> - An insert that lacks the required cap is diverted to a kernel-internal
>   per-rq reject DSQ and handed back to the BPF scheduler to re-decide,
>   tagged with SCX_TASK_REENQ_CAP and the missing caps.
> 
> - A revoke evicts already-queued and running tasks through the same
>   reenqueue path.
> 
> - CPU occupancy is tied to the task slice. Extending a slice requires
>   baseline access on the cpu.
> 
> - Kicks are enforced at delivery. Any kick needs baseline access on the
>   target cid, and SCX_KICK_PREEMPT degrades to a plain reschedule if the
>   victim is outside the kicker's subtree and the kicker lacks
>   SCX_CAP_PREEMPT.
> 
> Notifications:
> 
> - ops.sub_caps_updated() reports config-level changes per shard with
>   coalescing.
> 
> - ops.sub_ecaps_updated() reports per-cpu effective changes when they
>   take effect.
> 
> - ops.update_idle() is routed to the cid's owner, with a re-notification
>   when ownership changes while the cpu sits idle.
> 
> A parent can evict a misbehaving child with scx_bpf_sub_kill().
> 
> To make it concrete, consider a root scheduler R with a child A, which
> in turn has a child A1:
> 
> - On enable, R owns every cap on every cid. A child starts with no caps
>   and cannot use any cpu on its own, so a parent normally makes an
>   initial grant when a child attaches.
> 
> - R grants cids 8-15 to A by calling scx_bpf_sub_grant() with A's cgroup
>   id and a cmask. A grant is all-or-nothing per cid and can only hand
>   down caps R holds literally.
> 
> - A learns of the grant through ops.sub_caps_updated(). As each cpu
>   folds the change into its effective caps, A gets
>   ops.sub_ecaps_updated() for that cid, and if the cpu is sitting idle,
>   an ops.update_idle() re-notification so A can use it right away.
> 
> - Nesting chains through the same notifier: from its
>   ops.sub_caps_updated(), A calls scx_bpf_sub_grant() to pass a subset, say
>   cids 12-15, down to A1, whose own ops.sub_caps_updated() then fires. A1's
>   cap set is a subset of A's, which is a subset of R's. Caps A holds only
>   through implication cannot be re-delegated.
> 
> Using and then losing a cpu, from A's point of view, looks like this:
> 
> - Holding SCX_CAP_ENQ on cid 8, A inserts its tasks into cid 8's local
>   DSQ from its enqueue and dispatch paths, extends their slices, and
>   kicks the cpu as usual.
> 
> - R revokes cid 8. The revoke clears it across A's whole subtree, so A1
>   loses whatever it held on the cid too.
> 
> - Once the revoke reaches the cpu's effective caps, A's tasks queued on
>   cid 8 are handed back to A's ops.enqueue() tagged with
>   SCX_TASK_REENQ_CAP and the missing caps, a running task is evicted by
>   zeroing its slice, and new inserts are rejected and handed back the
>   same way.
> 
> - A places the bounced tasks somewhere it still holds, and the notifiers
>   tell it that its holdings shrank.
> 
> The final three patches expand the scx_qmap hierarchical demo: a qmap
> instance splits the cpus it fully owns among itself and child qmaps in
> proportion to cpu.weight, time-shares the rounding leftovers through a
> round-robin pool, and can fault-inject dispatches to unheld cids to
> demonstrate the kernel-side enforcement.
> 
> Known limitations:
> 
> After this series, sub-scheduling works as long as tasks stay within their
> cgroup boundary and aren't affined away from the cpus their scheduler can
> use. Two pieces are still missing for full support:
> 
> - cgroup migration doesn't move a task across sub-schedulers. A task moved
>   between cgroups served by different sub-scheds keeps its original
>   scheduler.
> 
> - there is no fallback when a sub-scheduler holds no cpu a task is allowed
>   to run on. Such a task, e.g. one affined only to cids its scheduler was
>   never granted or has had revoked, has nowhere to go. The likely
>   direction is reserving a slice off the root scheduler to run tasks
>   without cpu access.
> 
> Based on sched_ext/for-7.3 (3d1519011e39).
> 
> This patchset contains the following 33 patches.
> 
>  0001 sched_ext: Assert per-task ops run on the task's owner
>  0002 sched_ext: Make the kick machinery per-sched
>  0003 sched_ext: Add ops.init_cids() to finalize the cid layout before init
>  0004 sched_ext: Add CID sharding
>  0005 sched_ext: Add shard boundaries to scx_bpf_cid_override()
>  0006 sched_ext: Defer scx_sched kobj sysfs add into the enable workfns
>  0007 sched_ext: Add per-shard scx_sched storage scaffolding
>  0008 sched_ext: Add scx_cmask_ref for validated arena cmask access
>  0009 sched_ext: Build the set_cmask scratch from trusted geometry
>  0010 sched_ext: RCU-protect the sub-sched tree's children/sibling lists
>  0011 sched_ext: Add scx_skip_subtree_pre()
>  0012 sched_ext: Stop resolving a disabled scheduler's programs
>  0013 sched_ext: Add per-shard cap delegation for sub-schedulers
>  0014 sched_ext: Add coalescing sub_caps_updated() notifier for sub-schedulers
>  0015 sched_ext: Maintain per-cpu effective cap copies for single-read checks
>  0016 sched_ext: Add sub_ecaps_updated() effective-cap change notifier
>  0017 sched_ext: Generalize local-DSQ handling to rq-owned DSQs
>  0018 sched_ext: Add reject DSQ for cap-rejected dispatches
>  0019 sched_ext: Add SCX_ENQ_IGNORE_CAPS for in-place restore
>  0020 sched_ext: Add the SCX_CAP_ENQ_IMMED cap
>  0021 sched_ext: Assign a unique id to each scheduler instance
>  0022 sched_ext: Route task slice writes through set_task_slice()
>  0023 sched_ext: Track the cpu a task is runnable on
>  0024 sched_ext: Tie cpu occupancy to SCX_CAP_BASE through the task slice
>  0025 sched_ext: Add the SCX_CAP_ENQ cap
>  0026 sched_ext: Gate kicks on SCX_CAP_BASE and preemption on SCX_CAP_PREEMPT
>  0027 sched_ext: Authorize remote-move inserts against the placing scheduler
>  0028 sched_ext: Route ops.update_idle() to sub-schedulers and re-notify owed scheds
>  0029 sched_ext: Replay ecaps notifications suppressed by bypass
>  0030 sched_ext: Add scx_bpf_sub_kill() to evict a child sub-scheduler
>  0031 tools/sched_ext: Add three-mask cmask intersection iterator
>  0032 tools/sched_ext: scx_qmap - Expand hierarchical sub-scheduling
>  0033 tools/sched_ext: scx_qmap - Add sub-sched cap fault injection
> 
> The patches are organized as follows:
> 
> - 01: prep. Assert per-task ops run on the task's owner.
> 
> - 02-12: plumbing. Per-sched kick machinery (02), ops.init_cids() (03),
>   cid sharding (04-05), sysfs and per-shard storage prep (06-07),
>   validated arena cmask access (08) and the trusted-geometry set_cmask
>   build (09), RCU-safe tree walking (10-11), and gating a disabled
>   scheduler's still-resolvable programs (12).
> 
> - 13-16: cap delegation. Per-shard caps with grant/revoke (13), the
>   coalescing sub_caps_updated() notifier (14), per-cpu effective caps
>   (15) and the sub_ecaps_updated() notifier (16).
> 
> - 17-27: enforcement. The reject DSQ (17-18), the restore cap bypass
>   (19), SCX_CAP_ENQ_IMMED (20), slice-based occupancy (21-24),
>   SCX_CAP_ENQ (25), preemption and kick gating (26) and remote-move
>   insert authorization (27).
> 
> - 28-30: idle routing and re-notification (28), bypass replay (29) and
>   scx_bpf_sub_kill() (30).
> 
> - 31-33: scx_qmap hierarchical demo.
> 
> The patchset is also available in the following git branch:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-sub-caps-v5
> 
> diffstat follows. Thanks.
> 
>  include/linux/sched/ext.h                |   33 +-
>  init/init_task.c                         |    1 +
>  kernel/sched/ext/cid.c                   |  508 +++++++++++++-
>  kernel/sched/ext/cid.h                   |   17 +-
>  kernel/sched/ext/ext.c                   |  852 ++++++++++++++++++-----
>  kernel/sched/ext/idle.c                  |   86 ++-
>  kernel/sched/ext/internal.h              |  334 ++++++++-
>  kernel/sched/ext/sub.c                   | 1120 +++++++++++++++++++++++++++++-
>  kernel/sched/ext/sub.h                   |  121 +++-
>  kernel/sched/ext/types.h                 |   74 +-
>  kernel/sched/idle.c                      |    8 +-
>  kernel/sched/sched.h                     |   17 +-
>  tools/sched_ext/include/scx/cid.bpf.h    |   77 ++
>  tools/sched_ext/include/scx/common.bpf.h |   24 +
>  tools/sched_ext/include/scx/compat.bpf.h |   11 +-
>  tools/sched_ext/scx_qmap.bpf.c           |  852 ++++++++++++++++++++---
>  tools/sched_ext/scx_qmap.c               |  355 +++++++++-
>  tools/sched_ext/scx_qmap.h               |  115 ++-
>  18 files changed, 4238 insertions(+), 367 deletions(-)
> 
> --
> tejun
