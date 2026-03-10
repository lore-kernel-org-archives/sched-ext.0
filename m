Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012008.outbound.protection.outlook.com [52.101.48.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC7934D3B1
	for <sched-ext@lists.linux.dev>; Tue, 10 Mar 2026 06:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773125420; cv=fail; b=UEEmPvyqVOuXVATVwyzUWMsAaIt2FN7oUiSuJWI5+A2E1YU6RTcuGpxz0vvq8sMuXEVCuIJsq0rvJuSjluJ4S69DLj1AjdUp7nK7C5FjUS4Y2umktBVIkUUBD2uJ3G8X3DEoIL9S2nvp7SIjuofkYg81gb06LUVP/4EzRnGtM/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773125420; c=relaxed/simple;
	bh=bLqAbBbg+n1Lup5laNLmtKTuTQtTeY3zeUi6gqSSLe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JCeQKlh6gKc6otQyMWoVKh+h0WkUCp4EFB8nDwAO0LILOohR0ZrzIXo9h7xGs3qHQbJoGtlNpMGBTnWtuVcbkXHe3PMP0DfKBzBDs86z3CDtg8v2peyITF/cGCcF6lt/1FQfN0T4a3ZsxN6O6hF1Ho00ge0R2Dm7f81P++MGQDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LKI5v8Xr; arc=fail smtp.client-ip=52.101.48.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LKI5v8Xr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLHvi8oc2w0C21jMAVUQ81Eg2XmVMxCKU3Wv4KnCHTbxCVvOH7X2ugtOoU/WhSg3H6bRhYUDhYnYMLRlbZI2+hCs5P3hojHZmTllmVL/RFmlXDx1FYRdWqQq1yMphqT+GniIx9g3VQLW1OuXCiqMed+ccPKjyYUZuM5DwbxoD/RC9nv74CtuS3txT6LaROHLLfg2qN2rKn8hTIfvWf7d/+eh8fwZmz7e78L3ZPY55x4oiTIRBUXHHkdSgsZiGvq8SnkMxThSI0FTH56zx6d+3ZBzK5bvsvUPxKacpMOibZdU1xVcJt+8tc0eGr0TQVYAGSQdcQr6lWLjusuoMg/fMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxKlqd62YTwxuE/AXtzt+m0MGefoJo8uJKdqsyhyyJU=;
 b=vKazpzxnE+J4kpBmnGPjmB2OsEkOcKZivhdzsJQuuSHTtzvbTSgZEi6jhi6mNbg5FgUKcrhUtVDOX08oGHJ78CUDjCgVcnE7WbT5y1x+ZxTr8pgWffg2KiCZPzgpWxK5Gc1aRb8YYn31GwznHYL576aWAFS50v8pdiZTfY+6gf0hagR/nVMTGwZZAtOqo43D95TY4JH090PuLcBJAcMO0+FG9qzZOebL5ZcYtiIfw5Dnnv0gggglyjfew1u2nyf0XyFR1FB9i6IIa8buExv0sr0nxitUAFxObgc48v0JkKbXYWGtRw/EwD+AC+YBLf4tfYzO1Vlebk8uEc7hIRmDpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxKlqd62YTwxuE/AXtzt+m0MGefoJo8uJKdqsyhyyJU=;
 b=LKI5v8XriMuvyLvPRnFJjZYzhks7pOYo/hVNr/EMn7Aj3LGXZWTdVFM0mBzM2NOM7XccFxTUpj7vtFV9eG/u5UgZhJ6zZehlL9O2eMKDWxfecLE3HICXlVlEtzywH0zTa4hpG+AgbH57q4KYy3aYs9408BTUpEV2uVnzc2ou3L+Js9sv9f0eGYiTjYupxanaonhy5H6l7W/Ovdd5c1ppUKRBm5smYO0MQQoZKHWqSl4OdPFAL9wE9jJCSXbLjM/yqkiZeIhUM8D4J0hbiP+aFoCbAxTGA5mC28UMvfZhwHx7lMEFh03upyeLKDCKhmlvI3g0aFcLn6QtqZAEfSfFgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB8007.namprd12.prod.outlook.com (2603:10b6:510:28e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 06:50:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Tue, 10 Mar 2026
 06:50:16 +0000
Date: Tue, 10 Mar 2026 07:50:08 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.1] Fix sub-sched locking issues
Message-ID: <aa-_IBM4QwPxVvqf@gpd4>
References: <20260310011653.2993712-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310011653.2993712-1-tj@kernel.org>
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: dc212f96-000e-4999-6a27-08de7e7149ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	i7H+aldjJVbtplE9wxGa15EyyJrJNtQzHgt82ChrvKtu55/O1DEgOFErnzcJLrFcu8AcV/TVEt4yvG+rmtbdarpAR2T3R4FbqNezy6On8XJSrRDOlf9K1uXw0AhLZOn75ADuqzMl2xGa0/uQ4ZkNzZ433Mf9LqK7sqOC/hCJ9gP/AJSQkulLkV6smLjni7y1DibXo0zeL4n/eZEsGK017RAJxJ1Mx5OklfYeHAZsmXndz8Em45FCNmnRh5dih/jbCiPnYipwXGqiLdHT7wWV5rE1CaGsQkUPn27gg/NBA8h6M+PMjS4LAkTYS6cCak7YoCjDdnBgJ3Yf34FsG3hglhyzmlzkDyYSp/4aL8hASjYWQEdMivauTotnMkHnwJp/7F23c84xDru75fqRs/7qDycchOL59bvXOp25UuEVTmHi8IXJ391dY8/UxHr0RZsdkY3Qc41HmF4g+jJAFmndLCz1PQd8aCYt+GNm7F0obu4g8Z5yD478AHjLPvupslG0JkcxYit+CrejCxL3CbhXfaxvgkc53AJXD0okviI8XkWYWD/TEY90MGN3awMWdNa9KWnc3/gxB+6lv+endwbPOjeyxV10O3VrrhZ/71tuAF5jklzwxiTLBMGNHgP6LRwQSHQJVtimhzw8Lp1GzTuu4Bglhr757GfNStMHS4loz/fv51DEEiNQzZtjAHp6cOEOxrydeV5lG1wXcl5Ne5vLtHAWx2jQJkzWpdMkTnxIUno=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N9ySjxUpYcNGcOlNKGD7HxdVS1D3Io8xIdlYcui5xRmqRyYyYcjQ57Uo6byv?=
 =?us-ascii?Q?Y7QfLaV3Gs6PcUzASYJ0aQvnVQDoL5G+z4+UJ0t1dM4Li3/1UWe6talHyAfP?=
 =?us-ascii?Q?x1uQ90hvzHP+wDEJ/x8JLVOy0l9zPaPe0AeeSwTn5Dr+B/1L4DLPCCRIMrDt?=
 =?us-ascii?Q?dXvM6wdiE64nfgoYN0hD4A3mw+Q57geuobg/OkCzaVgtka6v1fFyirWYsYHW?=
 =?us-ascii?Q?7s9UMjmYWWYpRTrJLv50rKto1lDbGGBTx0yhUSvmRoxwIhhEogmmJqasZLaM?=
 =?us-ascii?Q?qlVgBY9+VX3K/acc8UWpG2GTBMo6qi75huRtDRMpDdDzQxQeUzIZacUlipna?=
 =?us-ascii?Q?GG/EY/6yb+noZUmE7/hCwrU8mvChJZkSj855+feSVRAiNTBQk/M6zTJeMDnv?=
 =?us-ascii?Q?nsbyPA64FLWYA14E66UcEiEn+7WUvt4J7QKRvZm9wGx2tiy2i7oHUfg816p/?=
 =?us-ascii?Q?rLhLgVh+mNnVIi1BcI2DFaSQkfx8JMV2YEyMt9j+stanzboZt/c2Y+VTqzv4?=
 =?us-ascii?Q?x1wW4eAiHKbSJPt4+o58GHM5knPhMyqsjcfkTPINpCMd+vSf+x1UtWvUtXzV?=
 =?us-ascii?Q?JsTNvGlibxacsdRA7FYTdPTC35TEj9wZMiUS6EnFzdqUWp/qDS88UAvinL/N?=
 =?us-ascii?Q?jHOOqbUI4c65QMId3dMz8LGe/lUtvTLIwIQE8VrN+ekJrXjTWchLiJCW6aZT?=
 =?us-ascii?Q?7H2bD1E8PVcfFXpBts+fgMvRmDsu0K/lbwSJ0gYUPQNM7DJPw4RRFM4LtvE0?=
 =?us-ascii?Q?hu0bEfFYKAOq+56Zf0b9NNcUOqhaFmbhQOYZTf8bykMqTluUsfyWw7t2pAei?=
 =?us-ascii?Q?BR5XDGrpqQD1L3lgc8M5L0yXOH3Dn2FysxskMMZylZlGhh0czljYAamlcXOh?=
 =?us-ascii?Q?kClTrw8BHPPcvIfxI1s/Kx58uG2jJkAKJvYsczklqkquM1PAqqHyX7i1AzE1?=
 =?us-ascii?Q?24ZRz5ItqAdID6sunfj5EqoZZOolpde5tlRUsES26f1X+OGMfmT4jvXddOwd?=
 =?us-ascii?Q?50jpZSdl0bAmXCbkeJE98tYt//Ucar5m8befB6qAENDOB4QO/Ih8iKEPmQMR?=
 =?us-ascii?Q?N6QbMq8CmfOCHxtDl7flW0QyQorqL2gn0RTlsPd5driy2PyyUWZ9G6pHAMNu?=
 =?us-ascii?Q?dqj9pDvz+2ghyBjq3TdwnvtXYvexdMU50NkXslR6QccoqIZ3t+e1TuArxtD/?=
 =?us-ascii?Q?t0iBvZq8WZuy+FjIYcYqrsludsnERrZgeu7hz+G1LvYlifxnbrWzRBgQEdWI?=
 =?us-ascii?Q?2AkCy4aVyvPriW/wBx2IExMNghsvGUntaBbYXVsmmd60wtpL6ysnS21/8mOV?=
 =?us-ascii?Q?ZIHps0ErvL3+T0YcMgwwpk4nuCi1Dcuw01sofL96TWFbQibmOQ+oGi2xoqvC?=
 =?us-ascii?Q?PRybnq+9Sq0UH22JvUYeCYhuLQiQX1R2xE/TiNRCzxc7zDHTQ/yeoa2UR1UR?=
 =?us-ascii?Q?Hlj0vbGnHcKnj/mwgnTX0ErnCyaZriA6Vu0MG8wIPbOvK7QqzGKgCtoDscia?=
 =?us-ascii?Q?Oe4zfIGbVskrxvHgpX0PjGZ3an000znq7P0BQYZ/QM06Ah87TKRI0aaxALx+?=
 =?us-ascii?Q?mGYmEJ7Lgs1Rb312yXRO8kfvsScN4G6fDaAac6vJhPVRk4S9gkK4Ndr1ZxAl?=
 =?us-ascii?Q?QZ6RAcb+XmmAISqtprFbk1rhtLIstKwsNqRYIeY9eTAzWZSGPZzEhIPKc3Lz?=
 =?us-ascii?Q?D/nL3v2MbtNjdLrytlLc8Y0+brMN+iuFAn+/WAK+P4FGrCbKMwqXNG3B38Zw?=
 =?us-ascii?Q?L0YYNST8lQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc212f96-000e-4999-6a27-08de7e7149ae
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 06:50:16.7482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4ReD/Xg+AQHHh5mXf1sfkBag8q5GXVzkWeJ9XBdX87RmyjABeknQBr7BPKRH2DbY1GRYLN5BtZNc8zOdelc5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8007

On Mon, Mar 09, 2026 at 03:16:48PM -1000, Tejun Heo wrote:
> Hello,
> 
> Cheng-Yang reported a lockdep circular dependency between scx_sched_lock and
> rq->__lock. scx_bypass() and sysrq_handle_sched_ext_dump() take
> scx_sched_lock -> rq lock, while scx_claim_exit() (reachable from many paths
> with rq lock held) takes rq -> scx_sched_lock. In addition, scx_disable()
> directly calling kthread_queue_work() under scx_sched_lock creates another
> chain through worker->lock -> pi_lock -> rq->__lock.
> 
> This patchset fixes these issues:
> 
> 1. Fix wrong sub_detach op check.
> 2. Add scx_dump_lock and dump_disabled to decouple dump from scx_sched_lock.
> 3. Always bounce scx_disable() through irq_work to avoid lock nesting.
> 4. Flip scx_bypass() lock order and drop scx_sched_lock from sysrq dump.
> 5. Reject sub-sched attachment to a disabled parent.
> 
> Tested on three machines (16-CPU QEMU, 192-CPU dual-socket EPYC, AMD Ryzen)
> with lockdep trigger tests and an 11-test stress suite covering
> attach/detach, nesting, reverse teardown, rapid cycling, error injection,
> SysRq-D/S dump/exit, and combined stress. Lockdep triggered on baseline,
> clean after patches.

With the comment from Cheng-Yang about fixing the link in patch 4/5.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea
