Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011071.outbound.protection.outlook.com [40.93.194.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12BC413220
	for <sched-ext@lists.linux.dev>; Fri, 27 Mar 2026 18:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774636925; cv=fail; b=Rti7z4Am8EHUjXvTOWSfS2XKu5dTe2316S1+0JN5jigU/YCrC20xPw4FSz1lbH6egP7IG7zJBWYuM1aTnBdI9mYCZ+fjRV7zzD0cJYRoauiqmOOkAGq6eHxxdkTXrTlmn113Ne533dObzKQN/4oTELUtwdk3zdtXLeHuy1pRCuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774636925; c=relaxed/simple;
	bh=TrU837QWnYdtCVogmGTYV35yaT6Q6yK0EAPuMeGeuy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bww99hVG0CIlhl5EMTXfn+hQzU5UfwOlYjU7LUrHOT2EPDRQVazEtrKD25HvCYkvJ7ZJWWR9KWE7nlSnD50iHk59vc/65mvwntp0vcJfUJ7zogmy2R3uus7MTdKZMI6iSS7aY/AqGvXtNYdakBN8gV/BGeu+xPP7kG4A3jpAmHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EMA0oADW; arc=fail smtp.client-ip=40.93.194.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EMA0oADW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kiW7xm9Nu0NG7D9V9aHF14Ua+fKUl3EN/aCchik4PSrKzT5xcQ7E7+fmoibSKZJkaMUppj9ZNcAmFZCdApy+pdJ7I8oZXdr+Ki8UThkrG4VeSqGLpEhd0660bQqcOe3fuVZRyXeCBoV2fzH86ItQTsfcu3TUkyDMLGz0/SFOe4/XE22KJg4sjVZ4DIkpmOHBOTY5pea0ghcIIzNpFbM+QX/9oPYmoqiOTp452dRRyv/Z/Ja93KaQOKCjbM1Vie1lOfvKVnCajC6RNKEczgH+GaTuXXR4+wQ21mJBrafTUvpmHwhWWI95ipNby1x5A1XyNEW+o32k0LtRlnWlQu2X2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfqb6BhhlFe3Y9gLmHmm4aIR1O0RTMotm/jaE3Aqmqk=;
 b=yRbxq3twwihCDYkyKvHKx5xaszSMaHP0vTT2rQ4Dy6984yAtQLkdlpL1fkmJAck75kbtea4LxTkWBnYlOsGlODYP/sk5wQz3voRQYgrp1etGWni3vkXHkSbp4CRkMhiTk1NBfFRwhrS5bAJhLQuGaNFAVXvCCh0ClhCmy32rxuV8eW+p1U6QIZnhd1XgH1BSzffz51bZF3MoH8aZDD28g+wC/5qewsG3w3GXdRjJuGQDEldjncc/ToVgkB1qe4+yN8yhHLmSra3LTB81Pq9iDi73jesmAM3djP8AyxfaRbH0bQd/uUZ52uvFXqK9ayqOkQTHvH2pb9IB5rIBx/+MYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfqb6BhhlFe3Y9gLmHmm4aIR1O0RTMotm/jaE3Aqmqk=;
 b=EMA0oADWdE9RPholBLHNpuLeNgLsQXam4C3TKlDl6ASIRNK+JKHngRfM7L7Ii/bLDE+7hEKHykzHl+NEHS3YtiD4jPjQYuwHwonxHbXmjZqEYMLSc9UKbzWrYe6JxI1ixQOwCjcnn2e31IMmcRG62LI/EidJxq20ioPWwrZAJZpVhQLRyfigHGxqrMbFyxARE+7AsvlHD/3g0rq6UNySal2/8lgIMZOHeKFsRKx5zOHU9NGv8Me7mE/1ktmP8LBJdK8Ee5nj/HE4bplLR6gfMDF4q1/3QgNY/7uauNfuh0SQ6iKu/3h9iC5pOu5oopoy1FCYV5Yt/+UuDAMC3oL/cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB7659.namprd12.prod.outlook.com (2603:10b6:930:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.11; Fri, 27 Mar
 2026 18:41:57 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 18:41:57 +0000
Date: Fri, 27 Mar 2026 19:41:47 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] sched_ext: Fix print_scx_info() build error on
 !CONFIG_EXT_SUB_SCHED kernels
Message-ID: <acbPa75X2LMsUUnv@gpd4>
References: <20260326081021.687711-1-yphbchou0911@gmail.com>
 <tmzdbaqgbe3vypfbm6gdih6svfs6pyrdpnklgmmwc47brnika6@vtcswuax5dxq>
 <aca8A9UdYV8nElsB@slm.duckdns.org>
 <gunjxqantrttj335ai73vkvddqj5swkkfwvm5abkwprhiwjwwz@wktl537f5qim>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gunjxqantrttj335ai73vkvddqj5swkkfwvm5abkwprhiwjwwz@wktl537f5qim>
X-ClientProxiedBy: MI3PEPF00004E95.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::445) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f1c3404-7f62-4e1a-2151-08de8c30864a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	p7VPIiQX+NvsJPqGKA0t9a6LqfEYNUlpudzVBjlyAXC/NgvqhHbbqOPyJfz/kW8xwCmFSZ/a07qgWFVhRA7iwdJjEbKgu1gxj+xNVzJPtzNdlLFqQ+JIbA94lHngyLwy3ToLqxUVS+Ahi9O6VOJyHcpuxREKVIv3NLZ3Lfgg/yNLPIjKxI4YYVuYPFe/J3UcHEeevuNEvHxPyBBa3P2jwPIZYpqBqXZfb98xh0Rz+L/lnRKzzKcCp2Lt9fwdXI/qu5/sqicco858TqxhlgFVNss5MOUd8p1AP0zDzByeazPqp/STT+SBbsfYpjvOMBd7Dg3zbeP1jXmaKaRearN3ZKZYb8om2VsHC0u2lIiBUHkuJr6H6RbU5MTPSpOPiy315QJzkvuoFjKcM2QfqivIIu5ZiwTcDtcFNYkMXXHZSD+SJn1ZOXFQfAf1/YmotzgaiEFV9iNFgXbYoejsUaTarN1YeIURqGf6lPa5J4zMZhdOGigMfqBiXV7BTIfhnfQgWthEKdp79P3s0Qr/2FiTeSSDHUbHJjtD+rY13GtCQrEh/D6+LYouLMTK27qOYGirIJwzg4dALANLSzU9RxkOhpz8ve5OoJVBzaKSsbRBkrQe2+7lENMy+6Wa8bhqywZjUQjGSeZJHfT79dMfYiu21x1bTVbauZqY52+WP7qP8xfxcycd8se8vFj2DYPdLsPe8Y0UIU6niar4qDt6HCdPKDCeKPNFfdv3bfGuAfmvJYBdmSzbVOlon63/xsHdTGKw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ChVYvjpZ3/AV4KDVcX2nFjT+obrgwIj7QTB97KAUnA9o/pKpcepUz5cZLX/0?=
 =?us-ascii?Q?vAkPsBr05EOxsGHuUEdfKPkkjCnlzoa095vaXUzwbvBwheFuQTp/TQUOvQ/t?=
 =?us-ascii?Q?Y/lz47S+rXHArsdsktTZg9IG2gy162huD+T4prvRs2Uh4xUKCVFs32p2Ji7p?=
 =?us-ascii?Q?crHRJ0WkwdyTKX5McS3PNbwlBCFyC6TUDJuUcjZGVMVLFoW/XY3qMWlFzfPi?=
 =?us-ascii?Q?+jvjvFp5NuVFwujjBqQ88H4hxK+5HJ0uXGTEcINMyuwAHKmTP+oVzLcDtPut?=
 =?us-ascii?Q?gnMhCpe4CHT11cWIXLfbaxmeA71uewim8trXHO3P3l+4xqbBXwdeaGA+tWsV?=
 =?us-ascii?Q?Hu6tGmFmIFq1cdVxQMdjiRvoAhonJhv2Eogm4I0qONHBWXMikcIo4NXH1fsZ?=
 =?us-ascii?Q?wQg3pBYgVKqG0nvdTHtQZGsOfwAZjzycSSCBDgTG7MRDi1HgFMKqtU5+qcF8?=
 =?us-ascii?Q?TfKc7g/uAv8bP6KezAMqMY9fD5SpzXhjCCXDyxSpH+TTFpBxSQZIy4a5vIlE?=
 =?us-ascii?Q?Pb7rAFR5yBELgyzLEQFbrJQUeozagYD5yQiUkZI5fGEuVAGU0MzqKBgnrx4R?=
 =?us-ascii?Q?7LFLWQ/X5VxsHh1WPLbBlbUqx1Xsvjyk7WqMu4BTft+hTkx7ACSk+pUk8wLT?=
 =?us-ascii?Q?12nWPJRe4gBCN1eg1nSgt5tW/DsRx/dq97wm2vYbS7UwerORfKN6MqetNpBb?=
 =?us-ascii?Q?8WewWCksDc/HBklWG6xHdm+wBIjccWmksAV8jp4aaJLUh7FK2miMhU7Am2DB?=
 =?us-ascii?Q?VMiDZNK18AhBm064TKRu/HZSV7UeHqyxc/mu3eFKF7TZJbGB8W/7z7k9rFvD?=
 =?us-ascii?Q?B/u/hU4z461/T/juiO7gi4rJ0iNoIT2MsNQC7C2dxiFszXpL9Dob95eo5DSq?=
 =?us-ascii?Q?n6RpZIxUTicNyVe9136DwgsisdsXkDeQdBQ9FnCADCHDKMnGhMTVE5FUiZ3N?=
 =?us-ascii?Q?ksZGMBxbPYNfwvmNhqWnZsW/IZ0ktr9Lm065k4yZ/TgAKcetaqGhdSC3rub/?=
 =?us-ascii?Q?WYldt7Xs4jAAMhCQZcuFgGql2W18SWSxV8ohb8LEkQpBW+ZUmWEBXITehRpr?=
 =?us-ascii?Q?AHgOI14H0+xo3Vg3uH9YDIPx7drq7rB2/R7IVTwAHrMSyIztzISFnRfHJVc4?=
 =?us-ascii?Q?ZbFVREpKqECHeWJkxoUe0smmuZpV+v240Q1j6USdYNavxzWXGIRaEcEIv/II?=
 =?us-ascii?Q?9QMujpvZM2W404SMOVxs63ky4kTRDST0OdqMgNs3103+sLb8C6c2clNaYWg1?=
 =?us-ascii?Q?LzYPGXYc2fTkrG1/ahwW8k4Zw9Ok5WMa29NWZspj5JIfmgGR6KJGR5Wep0eC?=
 =?us-ascii?Q?wUCuBW/qo8rNE/Cr78ZFa11wS+wc0JLf17HYJ3ZB5oK+cMWnrip2Ci6RJmW/?=
 =?us-ascii?Q?9ipC9i7MmLUTQl1247HtxRs7DnQXOvT+cJIV9bqloMzyuIL3PwBYtfB+r0px?=
 =?us-ascii?Q?r2vy/WdrhmeyZQ19ZYgz6J9iSax9kEmhyu6AixzfPiHtGJuU07THV7ZMWrRv?=
 =?us-ascii?Q?58pPbU0tZFTC6Mw3CVJnUdkPlWfJBbd4lAuJUyF2Uk7e11QfjBNOySzgmgXK?=
 =?us-ascii?Q?bVZF2BSvLPwo7K9HRZPhB0RTemPjwYVyCWNiOQ178lOvckDPPZfE/g7AoQJz?=
 =?us-ascii?Q?7nTwnTsBjUWZx+95aviFFPg8+HvtU7nnbJ2STNqPecqTYTiDrEF4Rk1OtvVr?=
 =?us-ascii?Q?d+CYjVqgUFGbyk9vasgRRbelB2CLvfh1LYQ/EQOS/fuxBm4hE+iwq0b0++0K?=
 =?us-ascii?Q?TvnPP8zUrA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1c3404-7f62-4e1a-2151-08de8c30864a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 18:41:57.4629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvLFtGdCLnLiYxbdEUVqL55acwzn+SA+4BCNdMl3IrLB6Zh6Y4wJ/EEWLdd0dkXQCcrD4sg0apg13xMaYMeapA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7659

On Sat, Mar 28, 2026 at 02:21:42AM +0800, Cheng-Yang Chou wrote:
> Hi Tejun,
> 
> On Fri, Mar 27, 2026 at 07:18:59AM -1000, Tejun Heo wrote:
> > On Fri, Mar 27, 2026 at 01:35:53PM +0800, Cheng-Yang Chou wrote:
> > > Hi Tejun,
> > > 
> > > On Thu, Mar 26, 2026 at 04:09:15PM +0800, Cheng-Yang Chou wrote:
> > > > scx_task_sched_rcu() is only available when CONFIG_EXT_SUB_SCHED is
> > > > enabled. Wrap the call with #ifdef CONFIG_EXT_SUB_SCHED and fall back
> > > > to rcu_dereference(scx_root) for the non-sub-sched case, which is
> > > > semantically equivalent.
> > > > 
> > > > Fixes: 60d4b17e886a ("sched_ext: Choose the right sch->ops.name to output in the print_scx_info()")
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes: https://lore.kernel.org/oe-kbuild-all/202603261453.8kiJImYo-lkp@intel.com/
> > > > Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> > 
> > Have you tried reproducing the problem? This is trivial to try to reproduce.
> > You aren't even doing the absoulte minimum. Before sending patches, read the
> > relevant code and reproduce the problem. I get that AI makes it easy to pump
> > up the volume but try to reduce the volume and improve the actual
> > contribution. Otherwise, I'll have to mostly ignore your emails.
> 
> Actually, I can reproduce this error on my end with the provided config.
> This patch does fix the issue.
> 
> I'll make sure to include the test log in my future submissions to
> avoid any confusion.
> 
> Here is the full log for this reproduction:

For what I see It should be fixed already in Tejun's branch:
git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git

From kernel/sched/ext_internal.h:

#ifdef CONFIG_EXT_SUB_SCHED
...
static inline struct scx_sched *scx_task_sched_rcu(const struct task_struct *p)
{
        return rcu_dereference_all(p->scx.sched);
}
...
#else   /* CONFIG_EXT_SUB_SCHED */
static inline struct scx_sched *scx_task_sched_rcu(const struct task_struct *p)
{
        return rcu_dereference_all(scx_root);
}
...

Try with the for-7.1 branch.

-Andrea
