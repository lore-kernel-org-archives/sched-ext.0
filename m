Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290E63321C4
	for <sched-ext@lists.linux.dev>; Mon, 29 Dec 2025 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767034533; cv=none; b=FGgWkB/bYCKNoxpWIGV7INtYq4aNYANBNZzcouF6EE+Wt1xA7Y16HDXXvza6AKid70nKfTmLtHPfG8lz53t/P9nOYCKvvl8/Ftv8LsPAu79mE4g9eTghYo5Ccp20sa+8RVsoSYVRki4qtHtO73gPPAeTwf5Oplx/dT7tDjvZUt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767034533; c=relaxed/simple;
	bh=cjoFnLYs0hXLzQWrJlFdFTYh+Jvet5KgFjIFyY4E0uw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=oTijkoaLohbIHCHRFDasQb2CxRPmd6s/YCR7Z55JOyXK/JjNrLJWP0nVdlK0fKsa6AcDKTq6aTy55lsWSqa4LBdrKdpTsgwWZ1fTcFEFS9ytXvi2GklbNAhvhpqwUQazbwS6/wjcUOEO8f6S2848DHY8Rq0TFUi8JTJx9b0EI4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=WEFdGAit; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="WEFdGAit"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4f34c5f2f98so104122511cf.1
        for <sched-ext@lists.linux.dev>; Mon, 29 Dec 2025 10:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1767034528; x=1767639328; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bFyx9qM3TGN99UnGzsweyG3odVGHIhrJQXh5a9SKgI=;
        b=WEFdGAitvoxTwtrEN0NQ2iNW78z9eD1UKUxLpl8iZcBtfgtsMv4tnOYXcJiA1NI3la
         rtN8pNv0Dn0yCrOFa+uo8FRav9E+s5bqlkyNVEqlh+OoHzO+9CM+QfsyAkAGqPRtjMuG
         9TccVIIkYrckKHYf0gLcmKQ5AiTHAenXkZrHTu2TbvVzpRvzg+st/Ocj7WbecVuRYArJ
         HtoGcQM8OEHwnyLdgEYOQ0/54b0TocWtep1iF6+Ak6HV8V1sRCP7OyTGxoe2Yi4dSggQ
         iZx+Rf5kuQmdM0pZyoJbxHeiIAWl+t4tqkUFo3VY1v5Pyhh4GdhbnsCNSMNZeJC6z0e+
         UFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767034528; x=1767639328;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6bFyx9qM3TGN99UnGzsweyG3odVGHIhrJQXh5a9SKgI=;
        b=mJInpVaaAqas22ztnDf2PoHK1QWAoLya3qFce6utM/sQjIYJMmylRgf1I9tovZ7OAM
         qwtQqEpQAUOLVIPbiFsMzvvjgqXtFY9A7SOk6cuUL+ykAu9+Y4SfQ2fmpTpSfoAs0e2/
         SpjUxYwS/yq1Iqq1Gc92xFlde4eo48hP7f74q2rb/lwKh5ksrJ2KE9xWshJUmy3oMnDG
         OYLLF9Umgmv/4Q/gRisJunFjBlENlZsdMj3JPbjydeMQn0xRKespASB++QiLPR6Y95cw
         GMR/F+nI31QODvbk+/FmWysmV6jkGB8Tr1/HksIGlQ+lxm30vCbfSnmr3FLl3HeYvczP
         hLxg==
X-Forwarded-Encrypted: i=1; AJvYcCXPsCczRFgdx5rVxVxYCMiQ7a2eQTnK0Dd1TXj6AbxGN+erjl8sMu2eV+rIChw4OiO9Vj31crVhUzk=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyrzzqy+nEuf/aSHqA5i2m0pBk71UGi34g4nvZbELMyYDxMuhH9
	S+32T0cvcCD20438vrHwGHF5q2LvtlkS5GQWMqgLz/jy8yuH2cpqgP0KXSavvyWTH54=
X-Gm-Gg: AY/fxX4iCbEUnrRsKshOBjVunhIjEzsYI8ER6n36FBPGM8yyLxyzwZ3QZjxKXdHbiOz
	9JlDGjdX07iPjzEMAsV9d8UeMJ6ore7XgNxQsABFkpWrCa0QlCKdc5vjUZVWUnBvr/qYsNqN5xY
	eUaNass84+t1jfQx2auSp8rfuqFqWw5IHMKd5t2fCOGoFRChRVSg0BycOA3lJJE2ekqWg/yWg2u
	xZ5kT/g5Aa4YdEBT77Y7ExJKgfhRp5NMLm2mvSs1E9WpRiJ+o/DggW78+sEVYVS0kuFbC6jRJqc
	3tkSzzs9QtanRXF0aej8Dn5t0CRI4oI0hIEmO+4Sp87KwHKnHrVHUDE8StOKHpMmZK7pC38dwBS
	JET8IfkrPQeeLIT65xWbG4tz/0EB0TnJaJsCSx70ZPlPtECZoUL/PVE69J5v4jPbcnUcfR6y6G8
	565zYSY1tenYw=
X-Google-Smtp-Source: AGHT+IFrwHFt1aHfOKlLIBCZlzI3NpSi0gqjyGcHD73ZWAtouJw5+qx0glKFUfHSH1ie9FuO8K7UZA==
X-Received: by 2002:a05:622a:5c91:b0:4ed:dcf0:6c42 with SMTP id d75a77b69052e-4f4abd8cb47mr520776471cf.40.1767034528560;
        Mon, 29 Dec 2025 10:55:28 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4b6760a43sm207769901cf.22.2025.12.29.10.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 10:55:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Dec 2025 13:55:26 -0500
Message-Id: <DFAXGN12DFCL.2AOFRHS9WWB9Q@etsalapatis.com>
Cc: "David Vernet" <void@manifault.com>, "Changwoo Min"
 <changwoo@igalia.com>, "Daniel Hodges" <hodgesd@meta.com>,
 <sched-ext@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Andrea Righi" <arighi@nvidia.com>, "Tejun Heo" <tj@kernel.org>
X-Mailer: aerc 0.20.1
References: <20251219224450.2537941-1-arighi@nvidia.com>
 <20251219224450.2537941-2-arighi@nvidia.com>
 <aVFmstVjLW_QIQis@slm.duckdns.org> <aVG9BBWIQLL8uJrQ@slm.duckdns.org>
 <aVG_WZCq5QlRgrqK@slm.duckdns.org> <aVK1a3pnCHnMWOWY@gpd4>
In-Reply-To: <aVK1a3pnCHnMWOWY@gpd4>

On Mon Dec 29, 2025 at 12:07 PM EST, Andrea Righi wrote:
> Hi Tejun,
>
> On Sun, Dec 28, 2025 at 01:38:01PM -1000, Tejun Heo wrote:
>> Hello again, again.
>>=20
>> On Sun, Dec 28, 2025 at 01:28:04PM -1000, Tejun Heo wrote:
>> ...
>> > So, please ignore that part. That's non-sense. I still wonder whether =
we can
>> > create some interlocking between scx_bpf_dsq_insert() and ops.dequeue(=
)
>> > without making hot path slower. I'll think more about it.
>>=20
>> And we can't create an interlocking between scx_bpf_dsq_insert() and
>> ops.dequeue() without adding extra atomic operations in hot paths. The o=
nly
>> thing shared is task rq lock and dispatch path can't do that synchronous=
ly.
>> So, yeah, it looks like the best we can do is always letting the BPF sch=
ed
>> know and let it figure out locking and whether the task needs to be
>> dequeued from BPF side.
>
> How about setting a flag in deq_flags to distinguish between a "dispatch"
> dequeue vs a real dequeue (due to property changes or other reasons)?
>
> We should be able to pass this information in a reliable way without any
> additional synchronization in the hot paths. This would let schedulers th=
at
> use arena data structures check the flag instead of doing their own
> internal lookups.
>
> And it would also allow us to provide both semantics:
> 1) Catch real dequeues that need special BPF-side actions (check the flag=
)
> 2) Track all ops.enqueue()/ops.dequeue() pairs for accounting purposes
>    (ignore the flag)
>

IMO the extra flag suffices for arena-based queueing, the arena data
structures already have to track the state of the task already:

Even without the flag it should be possible to infer the task is in
in from inside the BPF code. For example, calling .dequeue() while=20
the task is in an arena queue means the task got dequeued _after_
being dispatched, while calling .dequeue() on a queued task means we are
removing it because of a true dequeue event (e.g. sched_setaffinity()
was called). The only edge case in the logic is if a true dequeue event=20
happens between .dispatch() and .dequeue(), but a new flag would take=20
care of that.


> Thanks,
> -Andrea

