Received: from mail-ej2-f0.google.com (mail-ej2-f0.google.com [74.125.228.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5213F3281
	for <sched-ext@lists.linux.dev>; Mon, 17 Aug 2026 18:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786989929; cv=none; b=ArHxvLVK6PYi3OY/Sb8k12Xf2kEtp6NVt5hmVGbEaU9BzQ5cQATk0Ivlr/VnynMN7deCgrxOjHFDtMHcYS7OT+xwgbLpmrZoEsy930JETIZ5U8E3ZdzDP4jNwyL8BPC4stJ7Acgke4iwYTpwCcF6D6lY87RzLWV0c0n0klObkIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786989929; c=relaxed/simple;
	bh=puxzEXMJ5f+iK1f5IpCcEBy0jnFex294QxePdLIuumU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=I346eAxqzqiC9jDtGrWu0X25s8H7wBNbe6UxwulrPaoDMcZj2B0Ykt2J89tqFTBoReVYuwMbNTIjOtcFDqezvsry+pP4dPkLf8spSOIOllBYonoeFjTs54XdoJZ5N1fKcMZW/kbKGm306eqXooyNFN+Sxy/UOHHU8Pc3bchjvII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRHz6HQy; arc=none smtp.client-ip=74.125.228.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRHz6HQy"
Received: by mail-ej2-f0.google.com with SMTP id a640c23a62f3a-c15e57a4a49so81841966b.0
        for <sched-ext@lists.linux.dev>; Mon, 17 Aug 2026 11:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786989925; x=1787594725; darn=lists.linux.dev;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KYXKYw3ZJODb57Rt3eF8E0ND+mpiXq6EWIJdfMIbgcI=;
        b=LRHz6HQySD93KISZTBZeVbGyjSxW/VrucK1pzZwqKm+UI55kD2U9bjlneQ30EzA4vM
         UPz8nxsdG4hdoRUuFQht3OvNnozC28HwI0kZQNVpetwC5b6td0lO2b87vgqw5KXQ9JXQ
         Cn7FnW/ALhUAf4uXoFblW1rzqWR5UzXqlrKTcYsQo8XGZo1SH19BUa3yxYzO9JgmBSWa
         TZvth1avuOyiQdIG+QJH/sm6cfTTYZFBtezQ2Ua5asmzp7SWd5E6PRqcgVUoFYG7itIJ
         CPsD4+hZI6eetlnpGT7j6XOyiRVaYmkqkFjicpnhP5P59tHbnsACng/AGxpIvp6IinCi
         K9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786989925; x=1787594725;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KYXKYw3ZJODb57Rt3eF8E0ND+mpiXq6EWIJdfMIbgcI=;
        b=GbmO4X4yW+LLd5v3qDvx4GtBm+cKn9KWyB+UT97fgT2WEkPmQotd7Vek2izSERywIA
         DIR0pGplf8JGm/zrMkk3S2VNG+m1jAZzB2li+bm4H40/0GtyzpDDZUm74CRPJa/HoLri
         1Jbtan3K/AnK01WJfEZZJZRgKSFskvUW3QI3DPEsm/HTf8jvOJ3kLUmljQV1ktD0Jrv5
         FwYAVz0L9JfNoKyUPf+Jw2PHajTIXMRTXdp+h5Ca5+0NZgOayUJGo5MFH8wCVux8rrXa
         JzlS+OJFOoD/KtEIenEH7HBnQCTTdmDJ0Q6chnOrcmPy87Lw9dTXIOQzXZd31v5/BCtA
         bPnQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro0goNO1zD8WqvafsyvEijOw+8gYs1hrvTcfT9Z1MBXrhFpSuXT4eiMYLGKpZQ5hAs6uvj2UzEkbfg=@lists.linux.dev
X-Gm-Message-State: AOJu0YzP8Iez+zfOk2N2dMlzzbxiOCVsznBkVPyGPBRNh7F2WGX6OqE/
	SCZZ71xwfX7TUr5qvfu1l2d2kQLg+cf3GBd3gyl5uJ+hwW23Atc+XxGq
X-Gm-Gg: AR+sD13Gs7bYp6n1K/Vz5xbLHmH79CfFKjaJQkgfNlnM8GsMqtMTitFpcjAdtG1h3B1
	OXF7rP0Fj2P3v/X94uXdPEUaNDvxWagHqlCa0VebVGQ7L4teWrJG2jCVNBkCPvZflOqWzNZmVx8
	Xv8LGwl4RiWlXOjiwhP3rzSoPaoGqSkMGoywawyjRaizvC74nyJ3te6Rz7HazQhHQ/CsKa5S8rD
	kOSLUU3vRq5HVRPMMxniDvhCp46RO4219/7t2Al6j7NFIAM8fqUNeisarhLfIB1LOLmONu58JY5
	S3vBvzpEmtCDYhWjL1CDJab9RiPtJT5DFQVvklH5sHrptylcGZnGhDk8DIVWYh1W5xwSYhj3SpT
	43xcVIA3CkjcxT55HoqZjCo8kJ+MZLOtGsyoienWZbAAoI7qXRjmKN+YlarJeznDT8H1rGrGw54
	GGkr3BgNLJXyyq/4kYRwx1qMPdjgbDY4hDVjs4vNsPPKHRw8AXJAEo0T6H3qpRvQQ6xtsocc1jG
	nYE6WVHRiVQp50a2PU9UOBqSr9nwOjJO2Q+qAbJvUF3hPa0bNmPWPAYHIs78HF0EIbn0muNuQaL
	lma16uXEwnabt9BXuGP6l/WF0SU=
X-Received: by 2002:a17:907:3cd4:b0:c20:a243:9a52 with SMTP id a640c23a62f3a-c218ab5bfe4mr63468966b.0.1786989924403;
        Mon, 17 Aug 2026 11:05:24 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2187c83829sm34392966b.41.2026.08.17.11.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 11:05:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 20:05:23 +0200
Message-Id: <DKRF25OV39DP.2WZYYSKICG68H@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Emil Tsalapatis" <etsal@meta.com>, "Changwoo Min" <changwoo@igalia.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Shuah Khan" <shuah@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, <bpf@vger.kernel.org>,
 <sched-ext@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel-dev@igalia.com>
Subject: Re: [PATCH] selftests/bpf: Remove duplicate copies of the arena
 spinlock qnodes
X-Mailer: aerc 0.21.0
References: <20260803001807.646357-1-changwoo@igalia.com>
 <c9f8616b-15df-4c5a-8184-bf4d63813afb@iogearbox.net>
 <75bbbff2-5ea5-493d-b543-ce40d968f3cb@igalia.com>
 <CAMe2y=Gm9K3cwsM7Sff3ZaKani3z4tVUQv9u1KzbetJF8OrW=g@mail.gmail.com>
In-Reply-To: <CAMe2y=Gm9K3cwsM7Sff3ZaKani3z4tVUQv9u1KzbetJF8OrW=g@mail.gmail.com>

On Mon Aug 17, 2026 at 7:14 PM CEST, Emil Tsalapatis wrote:
> On Mon, Aug 17, 2026 at 9:02=E2=80=AFAM Changwoo Min <changwoo@igalia.com=
> wrote:
>>
>> >
>> Hi Daniel,
>>
>> On 8/17/26 6:05 PM, Daniel Borkmann wrote:
>> > On 8/3/26 2:18 AM, Changwoo Min wrote:
>> >> bpf_arena_spin_lock.h defines its 64KB qnodes array in the header, so
>> >> every translation unit including it emits a copy. __weak makes them a=
ll
>> >> resolve to one instance, but bpftool gen object merges only the symbo=
ls
>> >> and concatenates each input's .addr_space.1 bytes, leaving the surplu=
s
>> >> copies unreferenced in the linked object.
>> >>
>> >> libarena links ten such units, so nine copies were dead weight (bytes=
):
>> >>
>> >>    object                             before       after
>> >>    -----------------------------------------------------
>> >>    .addr_space.1 in libarena.bpf.o    676200       86376
>> >>    libarena.skel.h                   2100123      892371
>> >>    libarena_asan.skel.h              2641124     1466477
>> >>
>> >> Declare qnodes in the header and let each program define it once:
>> >> libarena in src/common.bpf.c, and the arena_spin_lock test beside the
>> >> lock it guards.
>> >>
>> >> Tested with test_progs -t arena_spin_lock and -t libarena.
>> >>
>> >> Signed-off-by: Changwoo Min <changwoo@igalia.com>
>
> Hi Changwoo,
>
> Sorry for the late reply, for the next version feel free to add:
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>

Added the tag to v2 and applied, thanks.

>> > This doesn't apply cleanly, could you respin against latest bpf-next?
>>
>> Sure. I will send the v2 rebased on the HEAD of the the bpf-next tree so=
on.
>>
>> Regards.
>> Changwoo Min
>>
>> >
>> > Thanks,
>> > Daniel
>> >
>>
>>

