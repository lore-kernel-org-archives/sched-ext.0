Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988194F7CB4
	for <sched-ext@lists.linux.dev>; Mon, 19 Oct 2026 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418090; cv=fail; b=ZI/xx276pUdzSDr3BAb4Ci4lfpYG6oEvSCzst6YMO3v1N3H985rXg8loDY/T8Wtx5qkY6XsiTBP9nQJ1PS9eyIqJ+OjaUtuyIOA+4QSFjfCYSKEVTBKPFuqjK6+Z0ECMZBBcrwTjNMpIp5HN+6neY46iFy+IUNXbwOIdLWuQmZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418090; c=relaxed/simple;
	bh=JM0YjG8nvVw9pjYzBghFmu0oK+bi83RM+sJvVxEtPz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E09JHO/sHh63j/DhJmXr1W7b3JL/MCtw07hGr3DwWYckbOfdiOJoqLCCE4dCJ1DfYGPIuDMd6H4FwoyxIEsbV/WCsb99AyOpJyCKhSAB5kv2cudF5VYP6xeqO87N0G+W+RPlt1uPuRyBBbH1HXmRoxJo4na++0X/KuQ074256gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IKnlaSY2; arc=fail smtp.client-ip=52.101.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IKnlaSY2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIAceooJjo0FD9VK27TSCCb4GtTOtqtjaKiNFAG/BbxGi2BK05MBj8sWUG5TcsV+HPE9T5117OZ2TwoY6cMymN776AtHmKEd2Slsj6TAtmgM2iY7W+foQ+mbuUlsZlSX5ZQS4+yYlr1mhM4gT62udOyzb/xl9ouDHdAdejfWVj+IZAW6HRRMkCV7AgqtYyscXr8F8O0lGAQfRdxHdowIbJQr9uPdGtjqdUz4stReI2hKZMSEKrYWxXpwXb8swICAq3reJUuQBOC09BlsV252SfQmAre6pZautSR0GBrYv4joXu0gyS7H7kjpe1RaNPrH8n0ll0Cg0YCe2rO8uKh1DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dD9/hvy8CjdpytNmMTQelv0WDFvgfCSAODHd8XjH8g=;
 b=aSJYNk/V89xWXyUQawe2DTjIKUY7bVI0xChXWHrAFDvytoNpj4rTBat+MPbY7hMvxuA8ImudXQar2ULiDo1oaNYztT5w1yU3GJpaQpnVIPMBN7pjw5Lo2uSYwMTYEAmsipPeDqNLa/TuF+T5uf1YuxKAinFPuwOm1rpLET0EA6X0uFqCsLgt1OQwaUherLNYIcPkAZL2yv7w73VYIlPYSvoyKzIFodqimeHZHY+DCL7gBBGDdi6SbbzvaPykc7rZSrSIadf1RXmhqsyXvnaaRPks9A80iCjJ69podBpE56PnCMwHL5lymAzemSS8/cMttxaAT3HuHYMQ4Ufr2i1bTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dD9/hvy8CjdpytNmMTQelv0WDFvgfCSAODHd8XjH8g=;
 b=IKnlaSY2ZMNZQnnRFGJGnBqF2+zjvpv/7OLYdyIm9ZDWlFlekSSP4FZ7wi0xHWj00R4JpszZEN8wSLjMViYutwF+vsNCPjOiKcsrWLpNtY80ddnC0rTLLUCl5ZPgbrwIr2Kir/enTORRFyHQ79Uq0ASn8u0J/4Ti7G4JfSSa2J0x/GRaWklkGiW+w8u0wwhmJFq56ZsaVA7L5Ku3+qeWg+wjkePqbloqIZJYPIufe5qBgjHwDFvR0McgegKfADY8ERYL47wmZY6QEiPrZNTS7oP/uiKVrysqhWARzYQQnjl7babSp3Ugx5jxHMiTq9v+AJvQ3tVtVWIGgTBUZwgqWQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 13:54:45 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 13:54:45 +0000
Date: Mon, 19 Oct 2026 15:54:38 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Michal Blaszczyk <michalblk@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Kuba Piecuch <jpiecuch@google.com>
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add class_switch_stall test
Message-ID: <atYhHvJAxLp01QbT@gpd4>
References: <20261019124146.3582127-1-michalblk@google.com>
 <20261019124146.3582127-3-michalblk@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019124146.3582127-3-michalblk@google.com>
X-ClientProxiedBy: ZR0P278CA0014.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::24) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|MW3PR12MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de77641-1864-41b4-1226-08df2de8882b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|6133799003|18002099003|22082099003|11063799006|4143699003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	+6ajNGDDpyztVfWwoQ7QCMk/4Er442QzhH8bq64r/L7BHaG8UnM+6AaEy4BY/yF4OpTPwB1o/PtTxJ3RsdponlkmukAGpMEftXpxHjGusVhrF/z9aQJPB4SduCjOakpg9wXpikKHNSUFfnhwC1lNvC2q/7rEoXH5LGREYtg4vx25he/cswsEyYZvq2y6ZE474R1/SIWw10soyo2zxYLqqQQbXuBB6oJvtCpNpFIUURmj/inNp1PtFOK/2AVVqF/5Wb2UVbktKaxgl4Ka/GhmHd88bgdMsghMxsNp8fh0r/PN5lpAuoWpViFRq2/6B6e6i6ODIesDXACrNfPOZLL5UJy6BZacNp8eXUrzsv3BH7rwE1jUGV/fDAnO/dzrOAh1pDFhgGlhNMLny6xJn+iQm3qsHtz6a0/VTC6rCjuG7CiVxjEsc0Cz67G4YewuDN8nATGNYFZoxcG1yr9ymAuPPGRXKedhwI1KXpE5bvS5WMvfvzA8Fv6mzUPQO2jIafbdvnx/UmgsVpwkhcKgAQlCHI6zPFa/X0Zj98LmGAOHOELbyOCBX+ZtXTvXixZOU4foRhVOJMcgiYxCSxWrdbWuDNuY5vZ1b4myctJVn2bOoKF1mL2WhMdKeahAZoLG8JDHXAgmtIHH8eLKOiZcehJ3HvaM+Bj25l+Ypj7csGVLf58=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rYXPqEIEybstq6ZvLv+Aoe9m4IYi6wYLvbRZdwUHJOqWI+OUUUpgG4B2XIly?=
 =?us-ascii?Q?0AHFMvf8FDFqfK2E/OpJo2hH9Z2crUPfOT8yC5tlafOmN9YXn02IJtpsaLGf?=
 =?us-ascii?Q?qfXw1/21+1iITafrgGgmReVurzK4EeS3jVNfipUjdRMcx9jvEB/jlF9Xs3UI?=
 =?us-ascii?Q?VyamxCud//616J1JCpVZ+qPrAVaVP8P1oby+08oA1TJBSgpqQAiGEocBcIhv?=
 =?us-ascii?Q?4y2d45b+Q6boDx6VQIPyvx/VFHJ/8Ntdd4oymF8RCZkwQXDtu5m2mwPIenSP?=
 =?us-ascii?Q?8hwEKrj/38Khs7na7K0ry5lq4kzmeYtfYqka3kegrMkqUdEVKN86fvPBFWQt?=
 =?us-ascii?Q?kTvrb4lHOH8f+VFkJCebf2hZ/YsL1I64tG5Uf1MmWUY/9Xg9RvFOUyhE9S9Q?=
 =?us-ascii?Q?4KvwSZGIPK/Rvipd0agX6OERPoLomyQDGheICO2CxWQ/Fi9zbNXgAbi1Mujz?=
 =?us-ascii?Q?X96LqAEh6+MuGazgbKiTf05I3gBK3CEha07fX8pfRdCmycCL5kHOXcRdmvGq?=
 =?us-ascii?Q?0RIlQXCTmbh0LB3oOiXLVigYIc3LPTwP15OAITmYeFVM2HWW16UR+e9oOx8r?=
 =?us-ascii?Q?bAfTiisjs64tIhQZ7fUOUoBsRRAozIzVsj8E6iAkI9uTQYi9m/AA6cne2Nmr?=
 =?us-ascii?Q?aQ0/YW1mMeU4V2agudTJTVyB7m4KPlFeCn9p1AWoGCfOIyo1R49uffUQRnS+?=
 =?us-ascii?Q?wVtW31F1dUYHtYJ0cMN293HEgZ4NUjkjjBkK0QaSJ7aPmLyWF2MddfESLMne?=
 =?us-ascii?Q?zXiUHvjwdiqWzq3/oU/p7VMwSSAWZPu5p85pRRm6ubIqprTA8LEUwR4ZKwmt?=
 =?us-ascii?Q?Rtjo/l1RUjV6CG0cL1j72uc4kPi8n9GhdW0xx+FS7oLk8CcrBRcbVDKt0xGJ?=
 =?us-ascii?Q?/SYnozPMIVuT2Jvu8J2nAEW62a2aUAn0ZQjatxBvimC+8L92zRYFZ0xdrG5m?=
 =?us-ascii?Q?/tw5nFqz9jY6M1r0bOiqHe8VBHpQkxPMv7cT6pyRuSWk4w+i2o4U6arvwLXN?=
 =?us-ascii?Q?N5pz2Ida/34TWy8ALu7KfKY/tb4Ra2Y4m8OGJ9C3sRdWPbEHeXkiXg0X2JRH?=
 =?us-ascii?Q?qcrQCa5VTkdveYSz5s/iQO69UGmWi3dh4a9St/bVQM8wy/cGYosFA6ZjV2Tk?=
 =?us-ascii?Q?KJprWZi1dMjKE6Q+DTvndLpDJ6SCwModcZ7qSQE270DUVET++LC7sN+eQi37?=
 =?us-ascii?Q?C1BxyX8rVyLlBnrnqc/7C+CTouOWArD8QxTs5WRCsW6vSNqP4xItWYhFYQg1?=
 =?us-ascii?Q?Bc+Xka3zQnuDmqBdZoHQdUt0GfkcT96SmCDVgPD6/hPaCmcOxmSfcZXp+uFD?=
 =?us-ascii?Q?r0R4AqZ8rdqyqYP3m20m4cLQzyXLJlycKrCms+KbXnBM2kzXonfKj7RE/fw8?=
 =?us-ascii?Q?H1R14XN8Cfk8YSEdkM0N0Y0ucvaRDMb3uoEfjEE9km5uiZA9Gmwfe/T+IxJI?=
 =?us-ascii?Q?SmfpkkWJntZBzfu8HwlFfmVYbPVooPmvRrh4iURMTrbJKN0soyef7YklypX+?=
 =?us-ascii?Q?EAMRZ5M7L7AamABAqMgvowVzZ2zt1o9r5O3ZHPS1I13hoSCmMR9SitALYnz6?=
 =?us-ascii?Q?lU01uQjuo77Lggy+TxmKEzW5uqyBdlL/ynYEEExYqGGxoB8Ny47voTxxX/OC?=
 =?us-ascii?Q?uaOpj2TxcxNqfSjuSk/0MsjbACWmrf12iIh2WzZxc7gt5i+nlXDTYllrsGCm?=
 =?us-ascii?Q?jQVVE3XxbmMy1q7J+cxeHxTERMqniUvF+oyeq+CFxOYGoGJHdAIsEtpbH5R1?=
 =?us-ascii?Q?WzUemmsDlA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de77641-1864-41b4-1226-08df2de8882b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 13:54:45.0766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9t3U78GOSvXcV9s+SKz/e2RUPZHe6sYPcyAVV02vSoVYsk8MpCJ/tU9FqGbxPWZAfeLoq/aVlxR7JlUZ6PqFCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491

Hi Michal,

On Mon, Oct 19, 2026 at 12:41:46PM +0000, Michal Blaszczyk wrote:
> Add a test for a task which leaves SCHED_EXT while it's waiting. Its
> scheduler keeps the task waiting on a DSQ after it wakes up. The test
> switches the task to SCHED_OTHER while it's waiting, lets it sleep outside
> of SCHED_EXT for three times the watchdog timeout, then switches it back
> and wakes it up. The scheduler keeps it waiting again, for longer than the
> watchdog interval but shorter than the timeout, which the watchdog must not
> report as a stall.
> 
> Without the previous patch, the watchdog charges the task for the time it
> spent outside of SCHED_EXT and aborts the scheduler.
> 
> Assisted-by: LLM
> Signed-off-by: Michal Blaszczyk <michalblk@google.com>

...

> diff --git a/tools/testing/selftests/sched_ext/class_switch_stall.c b/tools/testing/selftests/sched_ext/class_switch_stall.c
> new file mode 100644
> index 0000000000000..489d23c777f05
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/class_switch_stall.c
> @@ -0,0 +1,240 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Check that a task which leaves SCHED_EXT while it's waiting doesn't carry
> + * that wait over to its next stay on SCHED_EXT. If it did, the watchdog would
> + * count the time the task spent outside SCHED_EXT as waiting and abort the
> + * scheduler.
> + *
> + * Copyright (c) 2026 Google LLC.
> + */
> +#define _GNU_SOURCE
> +
> +#include <bpf/bpf.h>
> +#include <poll.h>
> +#include <sched.h>
> +#include <scx/common.h>
> +#include <signal.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +#include "class_switch_stall.bpf.skel.h"
> +#include "scx_test.h"
> +
> +#ifndef SCHED_EXT
> +#define SCHED_EXT 7
> +#endif
> +
> +/* class_switch_stall_ops.timeout_ms, the watchdog checks every half of it */
> +#define TIMEOUT_MS 1000
> +/* longer than the watchdog interval, but shorter than the timeout */
> +#define PARK_MS 750
> +/* time spent outside of SCHED_EXT, a stale wait would exceed the timeout */
> +#define OUTSIDE_MS (3 * TIMEOUT_MS)

Could we increase the watchdog timeout to 3s and the park duration to
2s, updating timeout_ms accordingly?

With the current values, there is only about 250ms of headroom for timer
delivery, dispatch, and the child actually getting CPU time before it
becomes eligible for a watchdog stall The first phase also depends on
userspace switching the parked child out within 1s.

I haven't observed a false failure, so this is a robustness suggestion
(I'm thinking at loaded CI VMs) rather than an observed problem. A 2s
park would still span the nominal 1.5s watchdog interval while leaving
more headroom.

Thanks,
-Andrea
