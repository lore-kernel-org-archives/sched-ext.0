Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B97F27703A
	for <sched-ext@lists.linux.dev>; Thu, 11 Dec 2025 23:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765495780; cv=fail; b=rOxigKZ7fCvSnJsI1NFA9HZ7C26Aq45QzuSOfgb21qf0tFmpqCJ4OF/myFeVi5PQXZoPEp0EccKzGqu97W6TX7fghBmHCyBazeGoxdTXJTvlGSnt0Cz30e23KCepR6wn+kpTh/SFw2viXF1/+gxi29zw16xPxxA3iUMnx5BameA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765495780; c=relaxed/simple;
	bh=CEMLPbtRSeeC7DI2kYLkoxzh5eYGVUDhVNYCkB1RtMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZVbWYrGbJjv2UEr9e5GJUp0ROzQiDxpt6seRD5BwWYvkqtGoceZfqRMnXGJmbhgCjGjieibiS3EJSiDrSgc6fpq78YQy7UL1+e08P1gyhQnfHV49ZU/4h7sll9Vw7tN+wlsEwotMaJ4Y93ptzAxpFDRUbOauuNp1Bnl0SgM9E0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RWmdaTWH; arc=fail smtp.client-ip=52.101.48.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RWmdaTWH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+7DYzrm7yKzwuh0NMMq+MKQPEqWET7mSkxyNLGGxRXR80Hb3vqXvfW1g9Gw8dUHBoj81dI8iks1NKXDkpaylSIj8oINtJjNnExw4MFtNsAMvtQbWPDlUaqJqGklsckMTIZteTg1lCUFLBZBQ7JrJGJXe+ho/vpQMX23ALAbd7D3eT93xPkk1WROow+4Fm8iCjCCM6vMZt0KX4vCwON3pHyaSaRH6FlqzjwpVP4xW02ot6bT32G9VikHAthJ/EODusfinyMSX+YYmUSTPfffeB6cVKYNbNIVp60A5LGchkoWW2x6Sk7dF689bNzsL4QYwVaZpinEzAT4T9ROuC9AJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xi71kMpXE3++nsmmfkSWeWgarktMX3MD82QqilymL80=;
 b=NpjNovOcYmgspkICKhhqQKd4Mh4+ntTjnTIhQ7yVjLq8grN8xbLJRMZ9XWPFowaXqxhl9J4fqry/K/tEx+qeH5WaNzJZiMs4mqhenoHF+BoWpoiaqERtCUYrwA7+qqIw2uuMqcZpgISuFGxEILYARn5wghSTKSACeluLzl20AtSPkrYd9FO470+/jCH43Viu+2s2OdAdZ4KoQ6mNPv9Ua3+DCzwQ92J6v1SHkoqtrvLpkL/yR8NfjSFsQDZtKMCUikThU8tO5r65KsM87XviWU/XhoulYWLlUeBh8/L42tc4CwGjHuVzg+Svy78TAIFRMwGkT2a6G1uCF1KIoR+5Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xi71kMpXE3++nsmmfkSWeWgarktMX3MD82QqilymL80=;
 b=RWmdaTWHqUpUZusADF6XjyxyRl80kYt5bz7rrJH4Jc93dYbeZCkL2Vwa2Ki+ZX9YazT3CYZnTo7e1FxK2nhiGsvIqSJBc/g4TRRCa5aXhDerBdumaXql/HijHV7piHs7942nHKkWdukMNvas7DR0cdmcW0GJnJ3PAnKTpcxCdksqGPXP1FxQLntJDpJvSBxO3+o9iRAIIZQYA5Lvyh6c2sRO8h6oDGflOV6wOyFh1xyBh54EegvVrO50RcC0N4yzd+Z7XuR2BQU43rgO9nQo5Tp02cDuMqTlvQp0hivcZIv3n9ktU98q8JyzFIH4LSAUqA1rn7xDVB0L0rLzXWW8qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by LV9PR12MB9758.namprd12.prod.outlook.com (2603:10b6:408:2bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 23:29:37 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::ae0:e4b5:9c68:2ea4]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::ae0:e4b5:9c68:2ea4%5]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 23:29:37 +0000
Date: Fri, 12 Dec 2025 00:29:31 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Changwoo Min <changwoo@igalia.com>, David Vernet <void@manifault.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCHSET sched_ext/for-6.19-fixes] sched_ext: Fix missing
 post-enqueue handling in move_local_task_to_local_dsq()
Message-ID: <aTtT22FI5MfSa_xf@gpd4>
References: <20251211224809.3383633-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211224809.3383633-1-tj@kernel.org>
X-ClientProxiedBy: TYCP286CA0143.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::19) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|LV9PR12MB9758:EE_
X-MS-Office365-Filtering-Correlation-Id: ab01f019-6338-4bb0-4876-08de390d2622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B+Fe+p1+Afwey9q4Vn8aWMKbtn9N/AEbd/7yAmqKrcHx6NPmy3aZnEZjY9Gl?=
 =?us-ascii?Q?GaAYxHcd0hOpBObTySgvrO7pGvJXSo0JvxhPyGfJuSQWLxVYF5ZgHzXDSyDx?=
 =?us-ascii?Q?QbxWpLVOaZISzZkPyRaOaiLAqAoB5EksjMHSBYIAHmWcsQCX0yOyjM6645RY?=
 =?us-ascii?Q?dWU1uYcitK+Hf7z228XT7A9wk6v6M9SztDfq8wRIBDCiRywS79CQNsC5somv?=
 =?us-ascii?Q?jpQzgRbegARQ55SZZ0pFUk+HnS/ZzcnFaWfyEOCpPhTKzDlhIB1LItUFW591?=
 =?us-ascii?Q?qdfexB+gqMC/MXdM+5xiaT8sZv8RKtjoOExWB8OcvNizCBvsPLGXjChhosCg?=
 =?us-ascii?Q?ZgP1iVELbzrJToxA82iXbkRrQR8IICJibEHKZ+0UbpxWtZ8rOkPmGlN7hOL2?=
 =?us-ascii?Q?n+lP0tddDSiETzlYGqw6/lUpXgrCiBKU5bzivKdCNB0stP9O/wmtTWkEv9vB?=
 =?us-ascii?Q?WBgbvycNu3/b6iZfBfcg/ykA+WWFR+YZXDv2ZDNqC7iDV0xGyaz2VeoJcFJy?=
 =?us-ascii?Q?BRdU6up+cyBPeLemFjE3vYXlF4ewSK0FcVbo8r6QswpS0bewunh5DFt08i3L?=
 =?us-ascii?Q?UluxG3En7bZ2PHD85l3mCu/wjxZKhD3hrdadN1zNBzvMnky+uWc91XOjaT0W?=
 =?us-ascii?Q?2wY6LfcrYwqWMFSou9o5puoFVrNrk0XjtCCj/rghyO6NJs1kaoZt+qeI+ZwH?=
 =?us-ascii?Q?NWTUVTf010t5cFGltDnyzW+UG8aG9jaEBhdi3Hje37TFh9XEvjs2IAgIQpJN?=
 =?us-ascii?Q?ryGqfgwUN13qBHTMLGi/byMzUT3UWJyvrFZV2II+CQQBiqf6cHQOZIbK4t9P?=
 =?us-ascii?Q?mKR1it6jZyOofRH4np6UgzNBkIo3iabErwKR4qNLpVtsteDtdLnB2kZqs7Cl?=
 =?us-ascii?Q?P4vobTkkfFxDkha5SiuIqsqDQxQ3bhVCPWw8GWp2eVf7b1zXzbca19OgVSlm?=
 =?us-ascii?Q?VLpiOR5yE5vDAaTOK0YodZc4+71bff2Kf6MPT6icVzlQw2mSKMCZmO/HB3tK?=
 =?us-ascii?Q?E4I5brBlsLlNOkLv4hkwyvJT35pjkwQxMMexsBKFOa2u4NZhVIhybHgm+9Ph?=
 =?us-ascii?Q?tpOVwpyLDdvciG5vjhyoPXjVWY7x/7qp5JcphmNSJ753DdsBAw0RPTlaPunv?=
 =?us-ascii?Q?T14ydjSlbCQglS0W4fZc5UamDoZrS/cFHX1xG101Br6tiLbWclSKJykxSWx+?=
 =?us-ascii?Q?GgufnpS4vPYZ5J0zl33jLr9YGvGIV+rY0Tan8svlgHv/+C4rmQClKcuuPIZF?=
 =?us-ascii?Q?AJbR4oOSPP1RwdVxrSK1vQ9sKXJaZADTi3YJBoiMsYfKEoch6vAp0b4CHbCN?=
 =?us-ascii?Q?20XTUiGWG6iVURX+Rpbs+hGCAwj9HNHTcrP+s0x726z2mfhXWsbXCxbyBI4+?=
 =?us-ascii?Q?Nvcp+OUkMzRUyTFz3eZRja4PIc8ccmeEJC2YXyZyvQbs0XgeovjQl/TtCqU4?=
 =?us-ascii?Q?VECbOk0GwTMbCjPqPjN6MY5XcGeLDyfB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yzYWAaFCHufCTNSASGvLwQifA8R6TTSz1mNbXENdm1ul5fB0pwmcrHzzmXeG?=
 =?us-ascii?Q?RLDH6dYckH9rzIxowCTyrBcX/3mg1gCb99TKIDIcs7kv0oHf3xPtabow6iny?=
 =?us-ascii?Q?S7oD1Ut37a5HhGsNyIM0RHlG4WaTXcZigBJA7g/jcAvGX2sY5L1s8Ll41m5V?=
 =?us-ascii?Q?oFwwqpS+6gFZGHxiBqDKgrUHadouJTkYChZiQH88lav2vNoZ9Z/JwKIbKOms?=
 =?us-ascii?Q?I3nWb1yHeEfXOutS1ax42+cD2nLq/GCo1PInLiO1dwdnY0HYcsRppwYcajaZ?=
 =?us-ascii?Q?KKkQ4LBiaqQLTIIMB6wV+xbAHhusywfu993OmcKYaim2+CAtsDX2iPG+hRFa?=
 =?us-ascii?Q?PlCvEm51GXH5M6+iZJaX9bqWkTTWhmsvl00mKFY3oL3pUJWMMWJWlW9y/8CW?=
 =?us-ascii?Q?zjBHQEQHtcQRlpnaEtShEIGTRBOcLIRB8rt09a2R2wb81OgbCIfcAYP6jLqK?=
 =?us-ascii?Q?qQoK2eXialJrjbXZHWbbCeo1qo/ZkLYgVWjkB1R+rtgJWGPgPU6+1fjBepip?=
 =?us-ascii?Q?53+SzxIBsWdhJWhXDjwYPYxU/OSohmS6bGTdCCK9kfqUL8rgBGTZxT9oVOWI?=
 =?us-ascii?Q?iR0PBjwjNEghYMgNuaohUTB3lTyiUne2jqA+dSVFso6NHbDf5I9Gu3eoA0IC?=
 =?us-ascii?Q?SzovIIb7NISry3oADzjuHD0qBBRtZcCHFd0Cnn4GYsIyO7GhiXbaZiiM/I8v?=
 =?us-ascii?Q?KKz3xOVEzd5JfFwN3tGrOu3GqhyceUPKK6KvtAVmxtwksE6Rx2dQ/15dQPEX?=
 =?us-ascii?Q?WojVF/bZEpDXKpOSvJ7YTvM/NetZcgmrjHc0qYML06i7RSb7tP8cH/Ig8oXr?=
 =?us-ascii?Q?V7xxlyxho7AjaXE4fzbDAgIf44diTCsaf6EWrPrydn4VV3R+l5DEL6UJgiDo?=
 =?us-ascii?Q?d2qB3S+LIj1K16z0D9rnj9//J+pzdjCQoWSqp8cvOabsZHOhBbsqoLfJl9gf?=
 =?us-ascii?Q?XyOfuRfK5cOHEuMpRV6yDUhbDflDzIhRwHrJdDCu5ssEKzTmVMokFeWYryPw?=
 =?us-ascii?Q?g+FN+CairMVMHP6pi4X8YzI+pmpnvwhqjAzIoJjlTCjiJUOKg1pevD/BGCx0?=
 =?us-ascii?Q?DHFli5VNA4973SHR/l4fbIB3Gnb8Ya6lrB2tjVJ6NfBczbZzg9faN30taIba?=
 =?us-ascii?Q?J6lryNMsrhSITBQ1i5aRTBqW8HDy1iQdoY4EnztjXXXkYrs8spCESoZD9WON?=
 =?us-ascii?Q?Lb6SiUcrrWLs0bJH+kZA6vW5FINCstZf2oYP3+IxxZeDKoERYQ282FI3J6+v?=
 =?us-ascii?Q?MOTQzJrhrHPqyOfodMpS0o5t9bD0ngXXEeeHbc7Y7kt+eU8k2XqhUt9NulEm?=
 =?us-ascii?Q?4Wng2+MSqGaX+LVV7aeTJyKkvdvLi1px3iDc1uTi9QUmpGhwEtggXGlFXXin?=
 =?us-ascii?Q?Yy+SkZFCnK9Z16gptc3t94FMq3GzozIA37BjL1aY4V2wPYCGlX29OAhFAYVf?=
 =?us-ascii?Q?cgVxMpXNlbI2TLT4S3xakS+vcYOhLSJoVIrjIOykN7UUJUrFlZ3XuwHuE5WC?=
 =?us-ascii?Q?qe2g9Rx/choCTOPgTQgatu6xTroB7VQkipywhU6DPdUN6dhk6l8OCcqu2+Vx?=
 =?us-ascii?Q?PM2Jd4FoaU/iZ+nMlNfQMVs8QAA536WF/0opodXDjlWYiJYBlxn1dfqkF25t?=
 =?us-ascii?Q?t3+nYAtJJqtYXun3vi/InIPwznWKzSmXBxf3Wd8PhVyF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab01f019-6338-4bb0-4876-08de390d2622
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 23:29:37.1702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /sB+0l2GwDE1MF3gmLQ/sTLmC9BBbo8RdkrfyCP60aNibgzSjxHtzdRJafmniVcbX2fq1lueO6+EX9HYvDSv/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9758

Hi Tejun,

On Thu, Dec 11, 2025 at 12:48:07PM -1000, Tejun Heo wrote:
> Hello,
> 
> move_local_task_to_local_dsq() was missing post-enqueue handling which
> matters now that scx_bpf_dsq_move() can be called while the CPU is busy.
> 
>  0001-sched_ext-Factor-out-local_dsq_post_enq-from-dispatc.patch
>  0002-sched_ext-Fix-missing-post-enqueue-handling-in-move_.patch

A couple of comments about the commit description, but overall looks good
to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> diffstat:
>  kernel/sched/ext.c | 44 +++++++++++++++++++++++++++++---------------
>  1 file changed, 29 insertions(+), 15 deletions(-)
> 
> --
> tejun
