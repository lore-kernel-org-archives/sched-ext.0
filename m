Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD2833F8D9;
	Sat, 11 Apr 2026 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775910509; cv=none; b=VCqfEeqk11QBkKc09uj/2uCFyeBmpcNYDxoPR8A0qW7CBj50x4vS8FBDA7CzFLaVIF4JGBLQsFKHuMqGbrQNzJZfxI9HgWpeU3ACDAaFgADVbqTDZazZGIGN7rEKoxvIW/Hck3o1RuC9I7sSr7mqY9hykTNjfzL739iFI1VGW1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775910509; c=relaxed/simple;
	bh=f7SfMQg+cA0NgaCiuvHEe9kS+dibktXxuwZMIedqxPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kj1Hqb4KHCzTJbgMp2xLZYb2b4EcgInezHnSjf1It5V88+Vpm0cuuIEg/KPxAkmTWzF6oa8OpTe6LjtG9RF8bE4srEHmLYReb+g3C7X+RqbDbRNsrRhRH+O0ff9An3Htg7FlNjHzCXMtrKkk3Km6U+2w66aBs2xHPZuq1GC2mbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Jeon7pdM; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Jeon7pdM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Q17e8cS+umTd22Tj+Lld3UsJlQkIMpk7Q60AHKIdGZE=; b=Jeon7pdMmDtw+nmpP89855s4H0
	P1Rlu0u75e7wutAvFG+aDj2zGRP9nJv4wPybQgREt75Vu7ETwjEX7ZDHNlKXbffEEFe/sUVUG558I
	vNxHjnVIH0aAqKHtPHszEG4hYl5UPrgi1TMotiaFnvaUUcOpGPkWQGUKGbFHXVujZwmZMXeAenU/m
	JPAZBfUWZKr8ycSkpCgP2whLAK+ZngW2UpCTY+trxNVAsZRC2KG/msgaij/Fqhq+7e6MhMtyU+tdZ
	dFNC9uyX11BJni6i5uYNIjHxYp0orF/53g+Boy9asap8KkTZDciAWl4Uf+PocGcEPcmnCkW4ocGoP
	Lhwe8mxw==;
Received: from [58.29.145.179] (helo=[192.168.123.154])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wBXRa-00EklS-FT; Sat, 11 Apr 2026 14:28:10 +0200
Message-ID: <f199597d-7665-4095-a69d-f4a3d1b2c638@igalia.com>
Date: Sat, 11 Apr 2026 21:28:03 +0900
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched_ext: Dump the stall CPU first in watchdog exit
To: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>
Cc: void@manifault.com, kernel-dev@igalia.com, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260408031113.76005-1-changwoo@igalia.com>
 <20260408031113.76005-3-changwoo@igalia.com>
 <adb-pduIY6oZxLYh@slm.duckdns.org> <adc-l_7ZNWLkyPFL@gpd4>
 <addHAYU_iKIC15nY@slm.duckdns.org>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <addHAYU_iKIC15nY@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

Thanks for the feedback, Tejun and Andrea,

On 4/9/26 3:28 PM, Tejun Heo wrote:
> Hello,
> 
> On Thu, Apr 09, 2026 at 07:52:23AM +0200, Andrea Righi wrote:
>>> Would it make sense to generalize this so that the exit record the CPU the
>>> exit is triggered on and always dump that CPU first? That should include
>>> stall case, is likely useful for different cases too and we don't have to
>>> add @stall_cpu to the exit functions.
>>
>> But if we record the current CPU the exit is triggered on, in
>> check_rq_for_timeouts() we would prioritize the watchdog worker's CPU instead of
>> the stalled one, right?
> 
> Ah, right. Can we at least generalize it to culprit or offending CPU? For
> regular scx_error() triggers, we'd want to see what that particular CPU was
> doing too.

We can generalize to prioritize the CPU that was caught by the watchdog
or called scx_exit(). Regarding the field name, I think exit_cpu makes
sense, meaning a CPU that makes the scheduler exit.

I will send out v2 soon.

Regards,
Changwoo Min
