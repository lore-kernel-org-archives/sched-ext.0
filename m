Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A064071D1
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 08:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327577; cv=fail; b=m9gbyxKXHmyD6TAs+3D/k00E53xcX8Io+IotRsuhUcf0khIMvxxmwY6e8gZaK/Z+wOKwuEhOg0i5ImfpwX6mCTTzQFWpFtihoh0Al8+PK+hTaa5E2mdhwBrLduzzBLP1K3R8siEy7hBpC6JHq95hDkYxubrfBhHEpMQsZcYTKac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327577; c=relaxed/simple;
	bh=SJ3uElBrGY3dqpkDnEr9tHqSGEannxCTJA2iVwOG/Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IdC35D7p9qhkYIomxH2ELDeB+ZMWyiO1RveGG4HxFLuRL7Q5FVhlICEFUW6BLLqyvwfUU+Rd2DVpGseAeLjUmNy/c27nvFz10ZKygcv4f9QKebJxPEU0VumTg4J1dJnrTCqA4hz4hB2NeZcj8ce1PQMh6ungzsBfqhgVJQAtTIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ygLk7jGv; arc=fail smtp.client-ip=52.101.43.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ygLk7jGv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzIHov2f5GfA9hUx652gBjdWzYb25dzwAwUVco97FRc5em4NjIRgKiaeD8i6uX5yJhR6mY27zZllxgkqcLKoTpih2sjX83ta5YE8F2M8k0tMQzqaL4jXkIAwjIbNJW6esRHlHC2XA3XvV0192i3h73PEc7XYW2fH5Pgz1yQ+R/gGdbSeays/IRISfPXa/FXU2XijpqjiVRYGb2bWZvCv0FvnOOEh8VmzmbLfUt8iPs8NtlD2lQyuaM6ZpRpxxy6Baba+5j47nkWIjX/ukZ+gYefHXiS7wFywLf1+VoqcG9xk4JPnn7mjRJ9gW8cYlWaTtFhcq2j9z+n5zWUNPN2AyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1Zj8FkeduGA/+RzhQWlFALTmrga0cL4OjXGEgWegxU=;
 b=izd6OzL+whhH3QjhQvf04nv5iUXCLC1Q7ecYWEnl2wTzkTIuhJAklGx6ArSQwz8XQ17tAf1mmykMatWQBnLB0+ctsslkUV/3q85P/vC/E9qcxZMPHKxkRCs0tEbB8IstmajXfm7Nv55490YR+TDLCGRNw6Jr8KINI0qS5HWUFG1ll/Rn5aabLyEk5ePCJ2q90sZdgPY77/rYBfztNdRiY6mTFXFZy7ffRdJqtYEiHY8v21kCTPCbSjLCK2pV1ni06/TFKe6URWvqd8blhVRpMr1TRoxDES/IWhJC8KLtdq8oFdqCsgUUozpJi4bLhc+xeBYwRBGGj1XINQfP2vu+EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1Zj8FkeduGA/+RzhQWlFALTmrga0cL4OjXGEgWegxU=;
 b=ygLk7jGv+AAi0bM8euw3bN/GdNm6KKX22gd2jf+gQW0N0vqJZBBVn5ekUwfC2ggTpFENbQBKLNn6FX4aG2WIZviDbtrO74nsTq+YU9P8kJmv7teIu9lUpJ5LchiuKjqfrLQBMHu7QGsYRo257XW00K+izxxBSqLIuCHyhxa1a98=
Received: from SJ0PR05CA0193.namprd05.prod.outlook.com (2603:10b6:a03:330::18)
 by IA1PR12MB6211.namprd12.prod.outlook.com (2603:10b6:208:3e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 08:45:57 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::53) by SJ0PR05CA0193.outlook.office365.com
 (2603:10b6:a03:330::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Mon, 6
 Jul 2026 08:45:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 08:45:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 03:45:57 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 03:45:57 -0500
Received: from [10.136.39.91] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 6 Jul 2026 03:45:51 -0500
Message-ID: <22d12b79-6a5d-488c-856f-1a4ab528786f@amd.com>
Date: Mon, 6 Jul 2026 14:15:50 +0530
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] sched/core: Drop mutex locks before proxy
 rescheduling
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>, David Vernet
	<void@manifault.com>, Changwoo Min <changwoo@igalia.com>, John Stultz
	<jstultz@google.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
	"Christian Loehle" <christian.loehle@arm.com>, David Dai
	<david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>, Aiqun Yu
	<aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
	<sched-ext@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20260706070410.282826-1-arighi@nvidia.com>
 <20260706070410.282826-2-arighi@nvidia.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260706070410.282826-2-arighi@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|IA1PR12MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: c53f8d19-feb5-4ad6-8434-08dedb3affab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700016|23010399003|4143699003|5023799004|11063799006|18002099003|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	N6HEPxnUX4FH+Pg/vaVupke9ANFQhJKSSO8n4Je6KwcxNqFj0ElSGM7zS6qiaXPFyrVvJ5PliAAfkH2oId22BFvub9MB0VpNtNp/ETB1Up+xnVd82AO2sJCzvmHoPB66f+3olnhi49eUOsqbcFHIGSxZ+gLAp7+jt7CrlaKqmfwXo9uYB16zJB11/BdDvWQ7UYvT5iEmGclUWuIlDktZU0sUHKe4Kl9wbd07FxgMcrqdNuUWv8a9jAPPhdiRYKKQMZiTkR3D/cu5GDgQt+ZQfCekYBZXUrCw7oh3Em339LGSkbVVp3Ie6KctddiYpwj+5RomnOW9oXmwoa7q+Nn/k4b6LtsXEBVU4okSHzzcP3cp5MHZ2Zyh4obQPxOXEs8fG/fTNXW55fIKeU3FHSEIQuk7lxwrXBtXSmjSThOu+d8dGJXMpck6nEJJUhR60QuEYQZ0Gh+kUfS8Me9FH8p/meqxKVxKvwEu+/yefIjiF80Fgkga3GK+Ox0kK8+hzYC1FdPEyylWHyLLUmuMzzc6DlHySPIXETzQzoThviB3Ygj2XvmtMEHqe0j6jLybMgHtYBVu1jcRJu5Yohj/m/NqzgcsJ1zDfvV5NLO1fkO/41a+v8Ifxuntgoz3/DF3LDGYXNFNJ1RfT+Nv/pJ9qtzVCunX6E4HstIPnZD7079E4SWrIue3GsFofgD1sx/JnI59rjU1eT+dZgcexE1hEnaiHA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700016)(23010399003)(4143699003)(5023799004)(11063799006)(18002099003)(22082099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Vj3zYYGgQ9J3+XXvfTdrMadY3qb3Ni1CO4mUCZYPiMhqybX8LYSoRF9LciA2b6r1U67h7cidJQjwcuIkG9oKcuSLVdeUI+KGneIdd5o4I3EiAFm88ZcV2CWmqBOIzfe5gA8XKa6A5KORPyitnT7Q6a7pry/m/b166/sqqe0Ifxs+90Lldg1+rFO2g5C9dpy+44qJZKvixx95EWLoa26EJ9xs2wHczbpkm4r8R3QPBF8uXAC7CmYttyHVheOmZRwmaNMEHuddDppvRZASEhAggqAj5luBQ8IaAC4/JP7RNCHVxoUsW1WZSl9O73w0KFfPkiJVnub3WWxalVI3yVJnkxmuVSxYULPB7+K+OhsgQXT/OGDISc0Q+MVRDGJwOOeRSxPvcD8N01oyup8r8FKeJOes6HBMNsDuhSFTg2mhEBe47dAXe+u9dvKfxdsixjmf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 08:45:57.5940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c53f8d19-feb5-4ad6-8434-08dedb3affab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6211

Hello Andrea,

On 7/6/2026 12:20 PM, Andrea Righi wrote:
> find_proxy_task() can call proxy_resched_idle() while holding a mutex
> wait_lock and the blocked task lock. Guard cleanup does not run until
> after the return expression is evaluated.
> 
> proxy_resched_idle() invokes scheduling-class callbacks through
> put_prev_set_next_task(). Calling those callbacks with the mutex locks
> held prevents them from safely inspecting the proxy chain, as doing so
> may require acquiring the same locks.
> 
> This is a preparatory change to support proxy execution in sched_ext. It
> leaves the guard scope before calling proxy_resched_idle() so sched_ext
> callbacks can safely inspect the proxy chain.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

I don't see the need to hold anything more than the rq_lock for
proxy_resched_idle(). Feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

