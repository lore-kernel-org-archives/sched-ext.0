Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011039.outbound.protection.outlook.com [52.101.62.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7C933A6E4
	for <sched-ext@lists.linux.dev>; Tue, 10 Feb 2026 21:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770758916; cv=fail; b=pcRqKY3qcb1TyEAPZNOcPXNCFyjjyWEOfUovKfRJlESTgFa2ZBzutwC+mFERPUgEWuvhy5jD9+TF91htiQJihKxUBVeqfhWzxvCpzPq8CL3DJbxhoJyXM5VFDkI9AP/hjOTDJ13hWOZi9WDk6QSYd05Nm3n3bWquzdJTR1ZR0g4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770758916; c=relaxed/simple;
	bh=j7qSVElz5PrrDooxLG4ReNzV21rMGOGTa9c3mR28RjY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eb33ki0Hu2NyHyripXAVUlG6yDTzpxnrAPLbZpmhds7deh1TjER6VZfEXRu4giP24OKWpl0EGGy7dQaBvw8+lcGPdxUKDSRK1JSpj9OuDWNooRDMRBJ/1YYHUrFpYrTOV9ISi5zHpKNXHrpXCJPKvYVot+r/9oFyjgcJRdnTsIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YpRnkqnO; arc=fail smtp.client-ip=52.101.62.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YpRnkqnO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AELUReyjBxb02LhvR41T/Q5G0UOyAmBfJARGBRkZvPmD6eePN1AbJFkuFe0FE8l4PC/qn3JsFzDn4i22Hyh1+QOrjiFNsLdRl1CuZVKiBTNTkUJwZYVzqTMZl/uj7xmGq8Mkr1VqTPBuXeTyMymwPCK9iWYssZCS70l/MCW7yY5Qv0PsxX+Y1cnJ2m2mmQRipd3xAp+cKc/hPeAaOK64u9bKFb+sg/WpFUvTwI2d/zngsjZK9kzXWYkT8Dqp7Uj8Lu/tC7/lyaS3zoOrCuPxjXZuubZjCDEX4h7G+Jw4w+JsYkONzKg1u36kVZ5xrnUMoz4NZBCOcTJxcJk1/IjirA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qpviyVHtCnQkQ4hkNIjf05IYsBA98UlOqt3U0fp3l8=;
 b=o0ae+14UbMPaMyrzl71a0+S+hDigCJilqtD/l9VqlAswWtQ/NflCAHfY++MuciFMU6oK0pwG8sdBQU348NP/qD2JpiCpZCwnkjQZCgkiMpo8gumb2XoSt2hifxXGMrHgK8NiV67JMJqjliUc97lNp1gcOPSc0bzIdXAmiRx9qrzEXzEdXASDHrflA3t4H78CbhN9VmBO3aPZ4kREjLYWcgY2ThJBUeROx4OloPFsBA905Z/VtKi3loE4waxsMF7SlhmlP8ZJ9TguQwMZp+kwXCYIGl0rExUQ5LekRW6y+ylAmUqT5iAwAH+YEU0jwAEbC1F9OzClH7HEzLeUz/scrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qpviyVHtCnQkQ4hkNIjf05IYsBA98UlOqt3U0fp3l8=;
 b=YpRnkqnO29C3Vc95DMCBPI6cfiLA459Or2KIUOlbzhjjZ2nO16f8Wpv2RXR3v0GXCMD8QHiDAZxSc2caxfxz0+C6fV9kerniIb2Fc9eGoFW2Jdth82zd/mCdAg94e7CZvlRDb2S8aVMEB7caXfoN2mbceUAc0H+BHZJiE48Sheu7o6UdVWYKY8LL7ZiK6Xvzkd30dKXKBRdCazKS1KnLocZN90g8WZ2uStPEhteO02Ry6mbtUM+S6hP8HoKHPdCMXxnsrnpaoMegVq4Xata9Eg1VGjRaaJsxvNrS1lKUFs1fLczPa4kpL4ckZIafqhHxDnQ1f0C0Zv6eII+yE5it0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ1PR12MB6241.namprd12.prod.outlook.com (2603:10b6:a03:458::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 21:28:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 21:28:29 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v8] sched_ext: Fix ops.dequeue() semantics
Date: Tue, 10 Feb 2026 22:26:03 +0100
Message-ID: <20260210212813.796548-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0029.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ1PR12MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: c924a27e-a8e0-40a6-7488-08de68eb5580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CWv0kmsqOzCKKPFz5PmeCDFaRVWNLdG/SL99qsn5rVNU60NbB8DLNU21wK4U?=
 =?us-ascii?Q?GjHblpHAxjOhRy6KoStAU/FXsE/JuTQgqIbCR/65IKQfmvI1ViMPzTePk4q9?=
 =?us-ascii?Q?z7u6D94hN66Ny5z9p2QBnWRVHWUjVSjJan0gFhvoO2IqNimzUfQGVMOpK7OA?=
 =?us-ascii?Q?JwOGkABle5eav4DwNXNadnZoJnO0JMJNiBqzFfOvmi//bA8STUssqA3GT/ol?=
 =?us-ascii?Q?+kSLLDuQG0EDIcQ+Ato47CVv32KF0Y+7UHFOTPnXcTqyUvEMhVHoaO3SkCvq?=
 =?us-ascii?Q?jiEic01odrv3RSbu6QpjVVnx3rwV+kjoXnsxXNU3rAANgw89lrUkWze8YpC0?=
 =?us-ascii?Q?Kjia1f86soDRr516E6JNSPvc3gs73caexhUzWhgOTrnplAfVm97oNm5gS8hy?=
 =?us-ascii?Q?pmCVFHQYEm2qjEr8+qCnKND56VA8efHdQjs4f7Oew6peqjYLgEQwlo/ufD4a?=
 =?us-ascii?Q?9ECTueXtgG/a7r71aJtb1ea+CyTwvgwirZ3Ne5fmM5git9ZmkuBh9zQhcwMb?=
 =?us-ascii?Q?QHs747hI3QIeDb0sYHBgt9vVj9v4po8sWGfaxu6EXGyii+S/MIMQ4mXiepY5?=
 =?us-ascii?Q?/pcblI80bmE5+snbPr5VuSmEMDfOg5UkUNngSyxJLiPsk4zLDIAO7W0IbzlN?=
 =?us-ascii?Q?f52d+EkneKvR/BagDURNv8yH/MhoJ2ikE+PdrexAzgWEH2jBv30WTTxTJV5L?=
 =?us-ascii?Q?z6QDhn5xvuiravDIHrZFpX2fCOHxisPbk5WpaDVI35N22R3EUdxkmPA3+di0?=
 =?us-ascii?Q?wG7PIptpK5QfKgUZqNdpJmf7BfKP9cBNckjawQECvRcJixngQ/hENozfSTxY?=
 =?us-ascii?Q?335n/+toEY0qzqBcqYtPEap8gqBqkRSSHG8Mu6fhdwpavvOOZWl7J1APGbTC?=
 =?us-ascii?Q?j2R2RXHOC+1YVecCLuJeiCKuZYYby2acLYm/JM/N+h+sj8LRZarJdupX6Sgb?=
 =?us-ascii?Q?922HhwVEJ9B86xcztxfRNsM5voqy2XAxM+nnUeRtkrCwc8CBfIlszzK+LpD8?=
 =?us-ascii?Q?5kqj0yCFn2nAcdx3sMI2qCVKrGF5Qk6Rr6Nt1NYoZwumB2D0KJCuEpcUg2H5?=
 =?us-ascii?Q?kFCD9nPeBi+iNzLi4Zci735inWjNaaPhJtKQnqryTsBUaFU2FQVd/eEghtpR?=
 =?us-ascii?Q?oWAFzyvrKXaY+bxRHu18tqAua4bu3P1QQHEbl6py3LRNooDkG0l5HSUSv2FB?=
 =?us-ascii?Q?k1XO2ZeBudGf2e0k5AYpzy0DWm4ideaID6LObyTQT1UUuGbpHTq3WbXdtlD/?=
 =?us-ascii?Q?99S/XeeETRvDbPvtJJNgr+gL3ds/nbet2Y6zyfLgu3jKRi3IZnjWYCZ0zC1o?=
 =?us-ascii?Q?hz1OqaS4OvG3rMiPjZo7Fs0Gmzc3ET4rgbf9agyusAtXXJVSeOuDW+PI2gHS?=
 =?us-ascii?Q?RU1mR0f6MEHT5Hi8x7hl49nyjBXDu3wUBrbGPhQFvGEx83vl6vzv5p6XrzfB?=
 =?us-ascii?Q?CUdq7RxBECE4JM2VGbBpD4h9rVqUWgXgtIjvkalWSCPB+Lj+GaZh4wQC8CMA?=
 =?us-ascii?Q?kK6+f0Wn7Yzlbb/MxsY76YBBEQQzGjo/AgCzUueQlgJ3nGkRiTy1+wXGbfU2?=
 =?us-ascii?Q?gzFzcVisRyNwEF8DRgY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EpmDZQXRoScN3UZDhI1619iEjD/5fEBtEt+Irlb3wfgSNJMk6jebuRv3VNU/?=
 =?us-ascii?Q?9PXIki771euebr/ZymDGSMKQto8wGrJ1qoEBgUDXDluhrXK7QKRpnEtQQIjf?=
 =?us-ascii?Q?JkSSXMDsrpTpMYPp7r9olPfZ0UmOwZCkfVp+OGBKTiHiwTCm93yK2GSrnybD?=
 =?us-ascii?Q?Lb/YVJvE9T+z4fbvA1jDpjZbCfP/qd70r0zUmKwh9vrerA3A36CqREwiRJdA?=
 =?us-ascii?Q?ZqjAjHpl+S42K72BvNYtHFOrK1BohAOsSelMbRIJ+sEdce03e5oD6/sPWDOH?=
 =?us-ascii?Q?BKz2junBjq3+axPeZ126z6NeHbQ7x6mrhOHzhnYtt4pcWLLorNLPGMqIId/H?=
 =?us-ascii?Q?h1bqqNRhvvyv3QHIoH0wOBkbjZIRGOlRpCTpiZM06AcjxmugmroQFNPW9++w?=
 =?us-ascii?Q?tZuuuOxr1hqcHO7ZJKBy1vke6XrMEeiRICUye/DSuIDfJbbMRMCwwoR+0SK+?=
 =?us-ascii?Q?Qw2wuswk8VSnGnJpjuj4d+Y5qw5zhicMA/rQBRvvX3XPlPn4fzknxswf9/2O?=
 =?us-ascii?Q?fz6qdXkJfwL6qOe0lxn/5+xniN/sPPWckryqwT46X6aEVW+Ruw+XiPXi6Btz?=
 =?us-ascii?Q?+zGALFPboNjkY0Ji4UqIEwbGxOxajlvGUtvbOsl/+Tm65DFRHFZhtaop6piH?=
 =?us-ascii?Q?GAnRZaufAlujNOAbf+lCrk5r+JEUgWPSDVYLqJexpV214eD10Icj16tcZVlg?=
 =?us-ascii?Q?hMcg5oKu4ONLoq3PXyQjYx6JBYOON3r7DqlysvZ4Dj9ZNlNjmS4LgMT3s9HB?=
 =?us-ascii?Q?6cb6joKm1duzXQFNADyrqazcotUoCoRy/ktFndgLtc3YJMq6HqsxZaKsE4Re?=
 =?us-ascii?Q?0C3BmbLtdicm1ffMyzKaCiZEBE0ErsSJXqrIob/HL/QadpsjVnBmLP7odwNU?=
 =?us-ascii?Q?QQGNwMR04kZBF9cSTjYwjfUvdRGk9CL3V+mZtwKS1qVeCB33Uuh75w27Na1V?=
 =?us-ascii?Q?uI448svjFH7iRRN0KwHxqIPj/DRlmWXHWo3CzXe/o3Cs0HmDHKJ94L6SXjNz?=
 =?us-ascii?Q?Zw1g6nU5ERMPKdTxCist+PGGYpTRb6WGmQS8eL1znobJMYdJilCAv1CmN2F8?=
 =?us-ascii?Q?yy8sE9+QduuQn/IN/ikrEO5v/VNUVsTF5+bUdBU5on9vgP8IRxiHk9YV/Cq7?=
 =?us-ascii?Q?TqaGBKGWYjS8LFK0Zcr7CmtDe7KIwTziz/mO2g3uvTj0UvuVAx6OjdBcCFaJ?=
 =?us-ascii?Q?rbATC/BU0gQ9iB05XQ9mmvnsb2uf7DbE9afSqZoi6ofr7XcziF73czOk8L6D?=
 =?us-ascii?Q?OQeXn8/VA0NCWhED9JsiVMfuZ5kXXcNEyGME9xbbkPMmsvgQFThWYyMNdfJZ?=
 =?us-ascii?Q?9Sj7bDZQD95OOqrXbg70KpSOsqeiLBgUfXSBlhdX8FZfg5yyq79W0dDzMv9w?=
 =?us-ascii?Q?J0II4v7xIyeoeaYr9z1gqPWPv+JkXRt2kJo03IzfHPNuFoNScj1wA9MjZkJ1?=
 =?us-ascii?Q?Ut/KezQSJAE4fqzvL1YQsCoRpsnu27NRqtq+KY7f0HBVrigm2kXfAejVcxnY?=
 =?us-ascii?Q?WftYBr2/sGh2uNCWnB2PqjPXFhFTv45ZS6OL0T7lt+QxHQYGSi98ILPzZamU?=
 =?us-ascii?Q?SFR6QAcN069gwfZKZPJxg28+Jp24TG+nmAWlVTjfvWVZanzk4eEZjFg7vRgs?=
 =?us-ascii?Q?yGgGUY8F1VXLEus/EC3EOscR2RCv+7Zkuc84HalxNH9MpfiADPBgjXMmE4OK?=
 =?us-ascii?Q?f4jVM97zDpLlbMrr9nD7BfoorGXUmneUtGOFPtx2CjXtMIZ7iobh1RRNozz8?=
 =?us-ascii?Q?0nM125K0sA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c924a27e-a8e0-40a6-7488-08de68eb5580
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 21:28:29.6042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwMj3tvVXImYiDdjSmkt8Cdu7xOypn7JFC44W6i7Q3LUZoFBr/+J1x7A3Mkik6gsREBtgotrqFlIBn1x0mdPAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6241

The callback ops.dequeue() is provided to let BPF schedulers observe when a
task leaves the scheduler, either because it is dispatched or due to a task
property change. However, this callback is currently unreliable and not
invoked systematically, which can result in missed ops.dequeue() events.

In particular, once a task is removed from the scheduler (whether for
dispatch or due to a property change) the BPF scheduler loses visibility of
the task and the sched_ext core may not always trigger ops.dequeue().

This breaks accurate accounting (i.e., per-DSQ queued runtime sums) and
prevents reliable tracking of task lifecycle transitions.

This patch set fixes the semantics of ops.dequeue(), by guaranteeing that
each task entering the BPF scheduler's custody triggers exactly one
ops.dequeue() call when it leaves that custody, whether the exit is due to
a dispatch (regular or via a core scheduling pick) or to a scheduling
property change (e.g., sched_setaffinity(), sched_setscheduler(),
set_user_nice(), NUMA balancing, etc.).

To identify property change dequeues a new ops.dequeue() flag is
introduced: %SCX_DEQ_SCHED_CHANGE.

Together, these changes allow BPF schedulers to reliably track task
ownership and maintain accurate accounting.

Changes in v8:
 - Rename SCX_TASK_NEED_DEQ -> SCX_TASK_IN_CUSTODY and set/clear this flag
   also when ops.dequeue() is not implemented (can be used for other
   purposes in the future)
 - Clarify ops.select_cpu() behavior: dispatch to terminal DSQs doesn't
   trigger ops.dequeue(), dispatch to user DSQs triggers ops.dequeue(),
   store to BPF-internal data structure is discouraged
 - Link to v7:
   https://lore.kernel.org/all/20260206135742.2339918-1-arighi@nvidia.com

Changes in v7:
 - Handle tasks stored to BPF internal data structures (trigger
   ops.dequeue())
 - Add a kselftest scenario with a BPF queue to verify ops.dequeue()
   behavior with tasks stored in internal BPF data structures
 - Link to v6:
   https://lore.kernel.org/all/20260205153304.1996142-1-arighi@nvidia.com

Changes in v6:
 - Rename SCX_TASK_OPS_ENQUEUED -> SCX_TASK_NEED_DSQ
 - Use SCX_DSQ_FLAG_BUILTIN in is_terminal_dsq() to check for all builtin
   DSQs (local, global, bypass)
 - centralize ops.dequeue() logic in dispatch_enqueue()
 - Remove "Property Change Notifications for Running Tasks" section from
   the documentation
 - The kselftest now validates the right behavior both from ops.enqueue()
   and ops.select_cpu()
 - Link to v5: https://lore.kernel.org/all/20260204160710.1475802-1-arighi@nvidia.com

Changes in v5:
 - Introduce the concept of "terminal DSQ" (when a task is dispatched to a
   terminal DSQ, the task leaves the BPF scheduler's custody)
 - Consider SCX_DSQ_GLOBAL as a terminal DSQ
 - Link to v4: https://lore.kernel.org/all/20260201091318.178710-1-arighi@nvidia.com

Changes in v4:
 - Introduce the concept of "BPF scheduler custody"
 - Do not trigger ops.dequeue() for direct dispatches to local DSQs
 - Trigger ops.dequeue() only once; after the task leaves BPF scheduler
   custody, further dequeue events are not reported.
 - Link to v3: https://lore.kernel.org/all/20260126084258.3798129-1-arighi@nvidia.com

Changes in v3:
 - Rename SCX_DEQ_ASYNC to SCX_DEQ_SCHED_CHANGE
 - Handle core-sched dequeues (Kuba)
 - Link to v2: https://lore.kernel.org/all/20260121123118.964704-1-arighi@nvidia.com

Changes in v2:
 - Distinguish between "dispatch" dequeues and "property change" dequeues
   (flag SCX_DEQ_ASYNC)
 - Link to v1: https://lore.kernel.org/all/20251219224450.2537941-1-arighi@nvidia.com

Andrea Righi (2):
      sched_ext: Fix ops.dequeue() semantics
      selftests/sched_ext: Add test to validate ops.dequeue() semantics

 Documentation/scheduler/sched-ext.rst           |  78 ++++-
 include/linux/sched/ext.h                       |   1 +
 kernel/sched/ext.c                              | 155 ++++++++--
 kernel/sched/ext_internal.h                     |   7 +
 tools/sched_ext/include/scx/enum_defs.autogen.h |   1 +
 tools/sched_ext/include/scx/enums.autogen.bpf.h |   2 +
 tools/sched_ext/include/scx/enums.autogen.h     |   1 +
 tools/testing/selftests/sched_ext/Makefile      |   1 +
 tools/testing/selftests/sched_ext/dequeue.bpf.c | 368 ++++++++++++++++++++++++
 tools/testing/selftests/sched_ext/dequeue.c     | 265 +++++++++++++++++
 10 files changed, 855 insertions(+), 24 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.c
