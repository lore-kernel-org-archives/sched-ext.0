Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5237F30F92E
	for <sched-ext@lists.linux.dev>; Wed, 12 Aug 2026 07:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786518237; cv=none; b=Bj1BpS9l+BqgrR1/Dp6D0IUjFLl/kNR9+ywIEk+9O8+IUGnMDyvrxaFMHhTThGgsFxcDwAcXT34bqFWtccnOq09kL7GWNXlU9wCUDWVAm9O4rX0xPSvhNTBkE6sXyd+XfZfGLUu7PnCaz1s1tNfBfU1SPZphqufUp3kxIiQ08MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786518237; c=relaxed/simple;
	bh=GCkBXddSbeHCDvY1GzromperE2nmzYP3jL1SLw1+JJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S29Sm6s8xiZk3dbNrEc9o5guKtbdO5PSnp4Y9ro+tZ2ysiWAFQmLlIqr8CP2uHPA2ByTuytAZQ5SGnewLirYwBjkV+I44xAbcaWHnkB7WrsklvHrRsAurYe6iwyPEENdA9b44fIoRwzuY1dO3+UE+nRwDM8zcW7d2NwColMkSL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AwIq+J9d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AwIq+J9d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786518235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GMSQFwJ3Pn8MGM6lOdOzrV1KHdix97IWR2KeUG/GEeU=;
	b=AwIq+J9dxpqYQWpI96V9rbgJb1hxlMkzj1AcQiN5/EmSzIHw/e9412XXmI/d+xqKPYWkRj
	3vqiQWNr0UyzcChbdaQSDAR2AIOUV5EZjfVdMZRyCww5B50bvFclPeF00ElRiiUnECmX6d
	j14rpKS03OPNq1zt1uguIFbWWtPJLSw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522--KlUSLrGPRSpcIda3rCd3A-1; Wed, 12 Aug 2026 03:03:51 -0400
X-MC-Unique: -KlUSLrGPRSpcIda3rCd3A-1
X-Mimecast-MFC-AGG-ID: -KlUSLrGPRSpcIda3rCd3A_1786518230
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4954fd771baso9045615e9.0
        for <sched-ext@lists.linux.dev>; Wed, 12 Aug 2026 00:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786518230; x=1787123030;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GMSQFwJ3Pn8MGM6lOdOzrV1KHdix97IWR2KeUG/GEeU=;
        b=etNb6ELa35OdqVwH37Qoblqq24DbZyVIwVXfnHXsRPG+ju7Y9UnN1/yfGw066lcE1z
         OevBem8a+XXLvaUIk4GvWzBWpvxLrK2vgChu+/v3C36TVRI/vW0vE54bHeAjtb1mQeEQ
         /TCWh4sR7805wHkbajvy/sQYUBa3+mIi8UnYduRe7gfWpr0vo3TiQxl1XwiK8D3aPrqc
         NBcS9TwTJEIxQuFUhnWl9cqs/0EmPeUdr3mZFQrwa3Nmjmnt5vWviTDaUUJO/Xx8g9kq
         rK3apmEia8AKMoDgY1E9KU78J5JMVaQldb02qmdXPIYe39FYygo7FQgwYY8XzYl86hMA
         z+5w==
X-Forwarded-Encrypted: i=1; AHgh+Roq1fntmvInRyi8ow7cnmjSUs8eIuiBy0BNlFPtkq7gV3yfyqSeeCVK4jPC5c0nmHuyX5fjvCX4qN0=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6s5kkxV3sld37uevoyBasFod5Qn2lSXV/pXNuyXADUoqL3jCe
	fQhcEYYEWS/uJeUWQLRZZ/lj+NJWneN/x5U/KmyRWbPq6c3TeVCn+QnyflwPNpL1YlfXTrEjezv
	kqglzNJoA7IvUUIZJhKWoIRD2u1+TxTNgnpMVSzm4c9T/qi92dWSgD1s5asRP
X-Gm-Gg: AR+sD12WfvwHBaDxzuAgauMsh5U7/xQB3aj5EjalpaMkuPD8xyIyFGlYxsTBvOcCvHf
	vCQQSF/HlXYWPLbHEcdNvLa9oNhurlMBVmKBONderg60K4rxx3kSv/bIMGaOow2zadpN03k7Xeo
	FJ23/K3kzQ941/H6xoexybISf2e75FyPcsqDKeOnkoHBopYuvoXNJgjPMRdENIhBPpRzUFPR409
	fsT/Vq43uCZ5L8Qep7fV22imMsUJZ+X0u4zQlWpt03wQP4O5+vI9G7kfkbtRKlzo2ojVOm9huvv
	ccaUCp57uZkBfKjhOKQSBZ6A72hnoTqsYwkXD54n+p6/7N9W3MeVN1XPnZ9rZm15nbDKDT5draM
	THK2L8jycDTPBjfYnxZQTVpeNtpMPuzWS1SI=
X-Received: by 2002:a05:600c:138b:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-4997c30b80fmr29456845e9.0.1786518229782;
        Wed, 12 Aug 2026 00:03:49 -0700 (PDT)
X-Received: by 2002:a05:600c:138b:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-4997c30b80fmr29455945e9.0.1786518229435;
        Wed, 12 Aug 2026 00:03:49 -0700 (PDT)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997ada79a3sm46337885e9.1.2026.08.12.00.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 00:03:48 -0700 (PDT)
Message-ID: <02ce6b65-7670-4dac-ac9c-8875867d6ad3@redhat.com>
Date: Wed, 12 Aug 2026 09:03:47 +0200
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] selftests: add shared lib.bpf.mk to build BPF
 progs and skeletons
To: Ziyang Men <ziyang.meme@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, David Vernet <void@manifault.com>,
 Eduard Zingerman <eddyz87@gmail.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, JP Kobryn
 <inwardvessel@gmail.com>, Mykola Lysenko <mykolal@meta.com>,
 Nathan Chancellor <nathan@kernel.org>, linux-kselftest@vger.kernel.org,
 cgroups@vger.kernel.org, linux-input@vger.kernel.org,
 sched-ext@lists.linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
 bpf@vger.kernel.org, llvm@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260721174833.1232771-1-ziyang.meme@gmail.com>
 <20260721174833.1232771-2-ziyang.meme@gmail.com>
 <f2a0db3b-ac66-4b29-9dff-a691d9464123@redhat.com>
 <anTlFSsr5FqQt+o8@devvm16600.scu0.facebook.com>
From: Viktor Malik <vmalik@redhat.com>
In-Reply-To: <anTlFSsr5FqQt+o8@devvm16600.scu0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v19VejohRGU8eqtEG3Tj9Sxu-Z7vTfePZuWznryuBKg_1786518230
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/26 21:48, Ziyang Men wrote:
> On Wed, Jul 22, 2026 at 08:50:06AM +0200, Viktor Malik wrote:

[...]

> Hi Viktor, 
> 
> Thanks for your suggestions!
>>
>> Looking at the same line in tools/testing/selftests/bpf/Makefile:
>>
>>            EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS) $(EXTRA_CFLAGS)' \
>>
>> is there a reason why this is not respected and -O0 and -fPIC are
>> hard-coded?
> Yes it is true that there is no good reason. I will fix it in the next version.
> 
>> What if someone wants to build selftests (including libbpf)
>> with -O2 and some additional flags?
> I will add a flag such as OPT_FLAGS ?= $(if $(RELEASE),-O2,O0), which follows
> the pattern in the bpf/Makefile:37. So if we run 
> $ make -> -g -O0 -fPIC (taget libbpf) and -g -O0 (host bpftool)
> $ make RELEASE=1 -> -g -O2 -fPIC (taget libbpf) and -g -O2 (host bpftool)
> 
>> Is that possible with the new
>> lib.bpf.mk? It would be nice if it used at least EXTRA_CFLAGS or
>> USERCFLAGS defined in lib.mk.
> Good idea. I will add the EXTRA_CFLAGS for target libbpf, host libbpf and host
> bpgtool. Such that: 
> $ make OPT_FLAGS=-O2 EXTRA_CFLAGS=-DFOO -> -g -O2 -fPIC -DFOO (for target
> libbpf) and -g -O2 -DFOO (for host bpftool)

I'm wondering if we could use USERCFLAGS (and USERLDFLAGS) instead.
These seem to be the preferred way for all selftests, per
tools/testing/selftests/lib.mk:

    # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
    # make USERCFLAGS=-Werror USERLDFLAGS=-static
    CFLAGS += $(USERCFLAGS)
    LDFLAGS += $(USERLDFLAGS)

At the time I was adding the extra flags to libbpf/bpftool sub-makes, I
wasn't aware of USER*FLAGS so I used EXTRA_*FLAGS instead. But now, when
someone wants to build multiple selftest collections with extra flags,
they need to define both. For instance, building with PIE requires:

    make -C tools/testing/selftests TARGETS="bpf ..." \
        USERCFLAGS=-fpie EXTRA_CFLAGS=-fpie \
        USERLDFLAGS=-pie EXTRA_LDFLAGS=-pie \

Switching to USER*FLAGS for bpf selftests would simplify things a bit.

Viktor

> 
>>
>> Same questions would apply to other rules for libbpf and bpftool below.
> I would check it them as as well in next version.
> 
>> Thanks!
>> Viktor
>>
>>
> Thanks for your time and reviewing. Please let me know your concerns. Thanks!
> 
> Best,
> Ziyang

