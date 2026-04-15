Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1862434C134
	for <sched-ext@lists.linux.dev>; Wed, 15 Apr 2026 10:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776250169; cv=none; b=iNdZR+63XdvrNPrye9VNDpu5NalW/JzYi8E+b2JnKLHFKfYg7y2pm/5e1Qe93eT4QKOjvc1WZ1HES33o4PsGJhKKpO4SG/Mv9IICPd2XbfSfJDJgASxIW8OkN/FzHmsQltIsqyxePYS0XiaELb2U1XAhUwJbuLly7DPK+11TeYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776250169; c=relaxed/simple;
	bh=jHVvOd5i1D95JRofbD7/r9kqNcSPg9zlylIYgRryaME=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=FF0vL003CI1uWlJqrsVuEQzdP2HTM+LuzOBcN1k8kI2E6Puvzxdju+YtQsKG+wc2+osobgn7S/eCO7O0tVQ3ZvijzcKg2tSvT5qmMqu/m1fr7ClI05rEN7EP8HjrMqdkFk1dsBLjA+J93BEudzGHS6K5bxMYMvmrH7ukwYe8wns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=DwKEPKeI; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="DwKEPKeI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=MI05zINj80+hpwxXvauV31Qjoi0Ku4EoT1C66vGdPh4=;
	b=DwKEPKeIkH3iqPq6+OZh5yctJgTtNvPBVylHFYPr/sL0vxuH1qAjvM2eYv7pMO
	vsk43ZRjbtGWtCrNx+Y/rgYf5eB0VZ7PnqFAqvF4IguuP+7nXAkpAyBpNCBmsOqh
	R4mA2U0aHx/X4bohwqaleuFUR5TD5HLVCQh0lJJ6ngaNY=
Received: from ehlo.thunderbird.net (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3VyASbd9pMbZLCA--.63071S2;
	Wed, 15 Apr 2026 18:48:52 +0800 (CST)
Date: Wed, 15 Apr 2026 18:48:48 +0800
From: Zhao mengmeng <zhaomzhao@126.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
CC: tj@kernel.org, void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhaomengmeng@kylinos.cn, jserv@ccns.ncku.edu.tw, chia7712@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_tools/sched=5Fext=3A_Ad?=
 =?US-ASCII?Q?d_missing_-c_option_in_scx=5Fqmap_help?=
User-Agent: Thunderbird for Android
In-Reply-To: <yyq2xc5xpdop65bvs3t7ncmqvw3ilpby75ywzv7g4gmq33hsxy@pohcz6wovyct>
References: <20260415095418.307555-1-zhaomzhao@126.com> <20260415095418.307555-2-zhaomzhao@126.com> <yyq2xc5xpdop65bvs3t7ncmqvw3ilpby75ywzv7g4gmq33hsxy@pohcz6wovyct>
Message-ID: <51DAF579-BDFD-40C3-9518-F0FD21E1C669@126.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:_____wD3VyASbd9pMbZLCA--.63071S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr4rZrW5CFW5ur1fAry5urg_yoWDCrX_ua
	nY9r12yan8Zry3tw4avw45GrWrKF18WF48Cw4UWwnxAa1DJFn5tFWUAFs5ury5trZ7Zr17
	urZav3Wjyry09jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRiApnJUUUUU==
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBlxSyKmnfbRTesQAA37

On April 15, 2026 6:46:22 PM GMT+08:00, Cheng-Yang Chou <yphbchou0911@gmail=
=2Ecom> wrote:
>Hi Zhao,
>
>On Wed, Apr 15, 2026 at 05:54:17PM +0800, Zhao Mengmeng wrote:
>> diff --git a/tools/sched_ext/scx_qmap=2Ec b/tools/sched_ext/scx_qmap=2E=
c
>> index e7c89a2bc3d8=2E=2Eb5fce6dcee14 100644
>> --- a/tools/sched_ext/scx_qmap=2Ec
>> +++ b/tools/sched_ext/scx_qmap=2Ec
>> @@ -32,6 +32,7 @@ const char help_fmt[] =3D
>>  "  -P            Print out DSQ content and event counters to trace_pip=
e every second\n"
>>  "  -M            Print out debug messages to trace_pipe\n"
>>  "  -H            Boost nice -20 tasks in SHARED_DSQ, use with -b\n"
>> +"  -c CG_PATH    Cgroup path to attach as sub-scheduler, must run pare=
nt scheduler first\n"
>>  "  -d PID        Disallow a process from switching into SCHED_EXT (-1 =
for self)\n"
>>  "  -D LEN        Set scx_exit_info=2Edump buffer length\n"
>>  "  -S            Suppress qmap-specific debug dump\n"
>
>Could you also add [-c CG_PATH] to the usage synopsis in help_fmt?
>Thanks!
>
>Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail=2Ecom>
>

OK, will do it=2E

