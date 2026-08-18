Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B768A194A6C;
	Tue, 18 Aug 2026 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062581; cv=none; b=Kofxo0Vmuxxd3dpMgF8XSPMDFWmLrrHoCk8w07uW3S97aT7nhYTo/YtZ0mEWQsuxqKQ6bpBKKcjoqvI79UrJEwq0CoSeipoWKE8F2ma/PrgifuLSaAxRFI/SBZw8ca+evj3qaVdrovA8SYfroedgbd9TCbvAjUH+3+hc0AHw8MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062581; c=relaxed/simple;
	bh=8u0oCn+NiSuV+rYi0lA1lQCTq5qZsCZdVncaYbEYCbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KSTKoUlHraldHzymv7iSkunynUbGiSv+2eAA9BjNMfUts7Y0yuPvit1NNf6gIEKFo3Eb3b+0zNTfQX1XR2tuhEJd2imTgyL4ECo0veqyrVwQtIknUecup1Y/VuJOMPZVZeJwz3QypLXXS2PJEBGqFAUTV5GAz1kzwiq2yMz7138=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Jh5WO0a8; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Jh5WO0a8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=7tAq3rCowBXZ9SwgwYlVliEHJMSYCq4wJjeOTJnXxmM=; b=Jh5WO0a8ykWP8fdS8llEUufyVP
	p9AYgbp4feKpsazNsOHTyepHsW3yfRFVo9mzJ0pPm+Ph6jH4PPwWBiEtFrCyYdlWKp1owKn5A8RYG
	iZgEjoH/86srUXfNAoccgpa+y5mq3djHiyzXNwmitEc23EcCXsAray1wXWUWPYeLEaQ73SqqvDMon
	apd/cIbRA7MQ2uD6iUHymILwbCHXRb8O7Q8Zs+kVcEGpEH7K21AjuVdrbZn213nJjAjiyAeS7d07+
	5YqTah8cbKCUHVRUsIILZELqUrryjQPN8QxsprI/JBNnNPczkmNnU9HKqTSuF8Lsyu1rcP30xBovK
	NYXjYm2g==;
Received: from [58.29.145.179] (helo=[192.168.8.203])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wwKbm-005eOT-41; Tue, 18 Aug 2026 16:16:06 +0200
Message-ID: <2f65d156-07ad-40aa-9ae1-2e14f836cf69@igalia.com>
Date: Tue, 18 Aug 2026 23:15:59 +0900
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched_ext: allow ops.cgroup_set_bandwidth() to be
 sleepable
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, arighi@nvidia.com, emil@etsalapatis.com,
 kernel-dev@igalia.com, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260817170941.668571-1-changwoo@igalia.com>
 <9ffe41fba1d0462a27443e95c5e3e03b@kernel.org>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <9ffe41fba1d0462a27443e95c5e3e03b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 8/18/26 2:53 AM, Tejun Heo wrote:
> Hello,
> 
> On Tue, Aug 18, 2026 at 02:09:41AM +0900, Changwoo Min wrote:
>> +/*
>> + * Capability marker for userspace. The sleepable allowance for
>> + * ops.cgroup_set_bandwidth() (see bpf_scx_check_member()) is a verifier
>> + * property with no other symbol a scheduler can probe, so this no-op function
>> + * exists solely so its presence in the kernel's BTF can be detected. It has no
>> + * callers; __used keeps it from being optimized away.
>> + */
>> +__used void scx_cgroup_set_bandwidth_may_sleep(void) {}
> 
> __used only prevents the compiler from dropping the function. With
> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION, the linker can still garbage
> collect its section, so please add __retain too (cf. __bpf_kfunc).
> 
> Also, we'll likely accumulate more of these markers over time, so let's
> give them a shared prefix - scx_compat_marker_ or something like that -
> and collect them in one place, maybe towards the end of ext.c next to
> the module init code.

Thanks for the comments. I will address these two and send v2 shortly.
Regarding the sashiko review, I think that needs to be addressed
separately.

Regards,
Changwoo Min
