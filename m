Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012050.outbound.protection.outlook.com [52.101.48.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005382D73B5
	for <sched-ext@lists.linux.dev>; Sat, 18 Jul 2026 05:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784352907; cv=fail; b=aZs/NnN4t8PHj/CNsScdC8zy99y5z+QYAdAzJpgBfdjwbDE4V9WPMBw62wAVkzA3QSgSxLC3dPQq1DMpzrGOzknBi9KzRbm+YWbXRY+jODo3W0iK750gUpXKX0Ecx1SbKx/a8LE9wBXSEho4zUcTGDxZBdaB0shSUjwSLEgPPVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784352907; c=relaxed/simple;
	bh=qZeLTfOBpDFuYPxOVfi4yjLgcxriRy+X9c6ayXkHS6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hR5ZUtiikkXWxNlo9RcRXJh/PJH6VSheoYqAd9mDVfuzzYN8BiuCPWXJIXtMEDZ5jWisMhjSX8T9zdiQIlBhLNRK18lz+LBx3ZA+v0wnS2EnFVlUY9baxr4Cp5OophDqAmQ28jpEeV9ZhIVlsw8Mw1pfJqbjxu0B/aSYaAZZAT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MB3nbRcB; arc=fail smtp.client-ip=52.101.48.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MB3nbRcB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AL0Q0d1O3UKfIuvzDOkADASd9MS5o/RcpiRkT8IfwDF7zBuPRvSLsUiFh/hs1ixRNaZq9TOyBppD7M9XW8TFnrWtRL11llVKf3Hm4Q5FnQMbJwl2N1uDocMs3yZuIkpphP0JKzJcgirhCgtbeYw0I6tGmAolJ6DWvCfM8+fPM2BEckC8k5XZPDn2CVYF3Y1Kb2WstM+FSY+wABNI/QJ5wsOxsOqifYuE1Fc2xAv8LU71sX9NLVwET59bt/58VJOWR/yi8dnvqsEb199dQdlPXsiumRDsfSu81Xng+EPidTxQefDGfvQZgzhtkdTxibXHJcaNa8fChMtaqqwpy1bvyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVKNDePGuAIV0hE5OGnRX0kGsKlByx0IlLF8wLaHYbY=;
 b=Otr3PTcmLTA6d5E14cLdU2ULKSlJTL5iI/1BWU2JQSKmxjjjeLBAAYVuv5YVV02Bg2Zv7KR1ncFrnH6eDKDQ+9h5OLWXJZkyjz4/6toOEcHOX9996/LJDhO/Mw4+m2H75D+vHSkQFXkigqiI+mzYO2UFICAbTQ3LVsaHbpDXAfdDf9cCs/140AQ6MKlP6v0xwlWFdLKSULGar1PP0NTWxI+fJteMAnT49y5TRmc+N2LXvfk9kI+01Ko5B01NY5aYqOsR+bVGBRsQcOsEFtpvT2obhJeAWGDNfZibtx5wyyduQ00wYc3gKqKJRMMjVZyjVv6EjyXcupGOkUdhOOh1Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVKNDePGuAIV0hE5OGnRX0kGsKlByx0IlLF8wLaHYbY=;
 b=MB3nbRcBUoiPMVJ9tkAGAONiMgj2wiEke421KC2v7vI6VCVZvcfdkv/ofPwH+sxg1xdtYCyk8nAMEb1/Inmr9MVRXdCwbFfEwKzK+tX2aRpkGXqW9RgqcFn3aOwM9Jr+nxmpwb5l41SHUWWWpVH+5EEGSrH1I1CffJ9MZrwriCn/QPUiwn+ym9T7oSun8pRNWjoMP5vFgpQhBdWzHxqlQ5OfQO/CwocuCR0ohDBunqNrjCWxW1dZInPItcxBXwLK9l0XYbOzVy2FEY2TJOEtjDhexGYnd9iH7CnP6mQG9qvcJmq45XyAGwnd8Qo5gX3EDy+zuT4877bpspALLkOucg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.14; Sat, 18 Jul
 2026 05:35:00 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.012; Sat, 18 Jul 2026
 05:35:00 +0000
Date: Sat, 18 Jul 2026 07:34:50 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.2-fixes] sched_ext: Assorted
 sub-scheduler and cgroup fixes
Message-ID: <alsQelzJLEQkSfxS@gpd4>
References: <20260716213058.1739522-1-tj@kernel.org>
 <alnxrsexEe_nQwqL@gpd4>
 <07c4ead225875c51af6599ee22c2e7a6@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07c4ead225875c51af6599ee22c2e7a6@kernel.org>
X-ClientProxiedBy: MI0P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::20) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MN2PR12MB4408:EE_
X-MS-Office365-Filtering-Correlation-Id: f304f686-4552-40be-8cbc-08dee48e4f19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gY0B4ZN7sx3VYjacCiWCGvFLPlz9d9JT20hnldm5DAfniFVJ68Xs4iaehogkUElv7WLcjrLRMY6yjqfMPCLLfBPIM8BHti1Z+HWsuVYl5ncCRNjuqmwJV55pby+/YneZ+0yp0XUWdyAylSZuv4rL9qty1lmIwIdHCUAar/n4CJNOuo+7PsBdY0naMFP6cCpFVkNygm0Z4E7Am83PaPWzvlUa+fO32B6VQL/jvZnYRgkueug6i3X8ulRRfZj5DTxMo8kUjbid6ANdLigiDlunf8kOq1SQzlq1D205pybzfOh5vyaKtAOglL3xq/7LJm6j278M9PeC2s7m9e7YTmGKAdKtc5nnCXTJL9HN/OGDm8rHYQIezgeWkbF75EI3qeXZ/5oOlJi3EKBTc7bw9THhMSzONCiF9OXISUaqr/vGOB1xpI74Z94aSSycy+kB+AjOqbbCnDAJG6wumjsQeoiMOuVirm4G1x49GLuMNTi4JjNhp7uCXGoag+JLf1Kh1S49xrCbNX2/SbyKtzdh6aCoeBbBn/rhrwOhTw4ovF4/8SslUrCqB1gK8WApF0t3apWf4JI830YQb1pHVkkVKoDkEVoaFU8q049CFQmbwR1GL7LsukeNB9YsY5HIwcKl1s+Qg+5BianNJ3wyO54VhQO/BkCHfRReCfVDWSp+V+xRbXE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N3fHmI4jc/D9+zZ3t4CHQv8UEBSyasoFKkAxQTo39qaCIYItRyZrC53QM4zu?=
 =?us-ascii?Q?uEUU43ji58gp105mB/Guzv68ryJlW/ZFoQFczt5ejYSU8T+0UmZPtabj8NXs?=
 =?us-ascii?Q?ti0DwSB4C+w8H0tNctS0DH0BpQ/tfZ5RQ7TPo/k42x6i6QDgyZTBCTo5lyTC?=
 =?us-ascii?Q?wnJeTTUqqkevhir4M4V/2d2WdqIOM+2eNejGInOQdZFWFWHWyEUg2oshJCm8?=
 =?us-ascii?Q?8Bj1dLrtbknRg99hqglbwd+NzKcQbEKkhSR9mYzOi+0KDzQDrafkySIlZ6tI?=
 =?us-ascii?Q?ImWqsiah20FGZiDbjQfvxj3yp5V4piRbAU6uLoKvu8SMw5i2AgZ3txRVku0G?=
 =?us-ascii?Q?aDLvxo8XMHUKmB0LiKIIYN5kvlwEHBpSfIghR7DwhWhjw0qAEiwBO09Z3RQl?=
 =?us-ascii?Q?al89TEdJpQawtObvsvcpjARGCZSFFemaF4lsi8D/3JBMX4j7Oq4wyu88glO+?=
 =?us-ascii?Q?y6OC27OE/n73wqs/7Q/MtwRVz2wbHwrJ/XeXJSNrG8jh8FugZCuoqkkeo+dn?=
 =?us-ascii?Q?gcPdF7cJ/jXovWyic+1ojCfMuR7bnYIwXuVTgmKqzTpxrj2ZYzNyWrDe/ZKW?=
 =?us-ascii?Q?NQwup38CoeMtSB4F8CTERIORr2uQ2hYkxoCSO/XXYmVUR/5YUfKhfI8MVQEM?=
 =?us-ascii?Q?GDPWyYR5UMR81kQe68hrUm+tmOWbJ6ANOawFNbqTpcxTcDcB6ZBaDBQD0JvB?=
 =?us-ascii?Q?ibAxM1xFBIPmmdjLtGm6VXtejMJxbTLQOP4C1UO9TdTaxgxaf/uN/TSk7Vm3?=
 =?us-ascii?Q?UtfVgo9Ta/0uJxJNvQmpOnm/Lt3AL+/0XRdSEFco5cDhVTuLvarA+uXqloRq?=
 =?us-ascii?Q?QUN2CuYhufWboFCmBJREoi1JznANbSHMu/JONri0OFCbgPDsIgd1UCgX0V3P?=
 =?us-ascii?Q?DziQgYoVtEFPIXEIMwNZq1tz+hqjZbW82gqCgjirfH4vzgsO0vkv8CGL0Sf7?=
 =?us-ascii?Q?3BqWk4njnIocKoNBZsAP7+mQZRKD9BbcqBieXRi/7vzI9qCXDDQY2w/Y10EU?=
 =?us-ascii?Q?67kOv856rbwaRAdKY0dlMnWtyxGgy7W/eVCUZ0DwCSmB+wdiAkI7Yuxm/bIC?=
 =?us-ascii?Q?V0V8AxTr6bYhyicoxoHJ9dCgUyqBaatIq76s5mflOkypaeuWsIFBxbQOqfIL?=
 =?us-ascii?Q?bbhV3fVb85x1fHPRC0/RZOwM2bhiQQeScUkoB39iHDfa83/NkStyQ8wNDnCH?=
 =?us-ascii?Q?1lCfiu36gFi/H03hQTBmWOpvCnFW2kOBjIUEYnzekGM5bvU01+fDtwFoXZ92?=
 =?us-ascii?Q?9z8m8f9ZlqOZbgpMJm+Xmgb+QuFJgmpV7JtNW8PsjOyqZ7vdnuvAGNpW4pb/?=
 =?us-ascii?Q?nyZtqaPQipcGP/bjchjsNwydCNJ3X9gLqozwFcTZIovslcpGP0psBhx8AJA9?=
 =?us-ascii?Q?m4ZrLyCy4kVFX2uru9025/yqU+8xwPyMVWkgh+Iv6pGN9IJaAf3QmfA4Gb0r?=
 =?us-ascii?Q?uqY8qlvLzP7j/+cTAwHLjCMZJws4mQ3ij9ahN4UNl4cSvXG8O4uWM2h1/Uiy?=
 =?us-ascii?Q?jyf48uIu3gTDvB1TQKOHO94S/LYxorrp+WT8j/qshj+uwCwDd4XoTakv8uiD?=
 =?us-ascii?Q?4YyfhAF87CX8moFLMM+mg3RvPqik9P7wDwyLk3jGQTNzebAcnGrQL1BR651Y?=
 =?us-ascii?Q?q4YYFo7GuLhcOx0DtBNw0GN6+LT4o40Bb/XqHmCEf+sEQEEIjc+rL5LSiZGU?=
 =?us-ascii?Q?BBPUCBYTAkxAUUTJtyMNn9fcvHTFkxpb2pKYYHRB6pkow0dAChDii5f4Vjci?=
 =?us-ascii?Q?PJqbZM01wg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f304f686-4552-40be-8cbc-08dee48e4f19
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 05:35:00.0969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +1dsghOzXbukddXG4Qma1OShAkRBDgFCj2s4JpFsvsgYphiUzMUmQbjDQknYqL7NO+dNEV3fGNhHElcydqEthw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408

On Fri, Jul 17, 2026 at 06:12:06PM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> On Fri, Jul 17, 2026 at 11:11:10AM +0200, Andrea Righi wrote:
> > I randomly triggered the following with this applied, but it looks unrelated to
> > these changes:
> ...
> > This might be a pre-existent bug, I'll investigate a bit.
> 
> It is pre-existing. Cgroup migration doesn't update p->scx.sched, so a
> task moved out of a sub-scheduler's cgroup keeps pointing at it. The
> sub-scheduler's disable path only walks its own subtree and misses the
> task, and the task ends up holding a dangling pointer once the scheduler
> is freed. In your crash, the watchdog read a garbage timeout from the
> recycled memory, declared a stall, and the exit propagation then chased
> a garbage ->children pointer into scx_claim_exit().
> 
> Reproducer, on this branch, KASAN reports use-after-free within seconds:
> 
> 1. Run scx_qmap.
> 2. Put a CPU hog in cgroup A.
> 3. scx_qmap -c /sys/fs/cgroup/A
> 4. Move the hog to a different cgroup.
> 5. Kill the sub-scheduler.
> 
> I have a fix series which re-homes tasks on cgroup migration in the
> works and will post it soon.

Oh I see, thanks for the details. About this patch series, everything looks good
to me, so:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

-Andrea
