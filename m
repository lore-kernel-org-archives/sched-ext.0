Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C2A391833
	for <sched-ext@lists.linux.dev>; Sun, 11 Oct 2026 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791740446; cv=none; b=R3J5Br55n/Rq+VmsB+HKh12p/zk5sOuiQCfbtaPGacKROLVIf0qeB2iUsj0tyubYKMRIHH//FwlDhtjBWsXEVLK4+tqsY71R7ROivhVfIYCq/0ESwkP9KtKpYw4cmqmuS4Ur2F1JXT4E4KykkfMGP08WSQTxsEAXXxryybPQnm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791740446; c=relaxed/simple;
	bh=w3rpF15i6oAhEioYAhAAF+3ymkyfHG5hhIacF+l8vRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cu9DAqjN0+ROP7J/rUxq5NrbbS0thbPQi2VBC3Sc+sO16IJPrTygREHQmgpL/sNiCUWnZZypYuIspEkRJiIRWaCRAQWD6yN2+USXTL5b+xEm+2LbulaapsTUISjG9f/0I7iq7rYDtbGIGic5iI9O9nuLsmAVPJvot8HKAS2Xv0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDFcMzxE; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDFcMzxE"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49e71fc84bbso832805e9.3
        for <sched-ext@lists.linux.dev>; Sun, 11 Oct 2026 10:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791740443; x=1792345243; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zvh6uQ9bGzCwbdbYbC1n1+7RZUsbZpcs8nWAcUfwSlg=;
        b=dDFcMzxEPW8grijhRjZQTvDAQAhb8n6qkyfLke4Xg7GTaarBB78DThdjgVqQZAeD+L
         77OzPi5BUGi1qe4wYAVC0BQPBtBtVoBnTPta5WurrznzLsg/UfGKWtYBCR+pWX0qrnu4
         nELBrxdBTKhadTE36ATe16ZRfxsHElTlKu9Q/1EAKHTVp+AAfrbn6CNK66o1QeUQIJrl
         5hFI9CJdlgiszkDRhUkmrMIHFwUSEOVzQ3PT/28QtK6AOEahF1L5mOEz2SX8R884mJOP
         P4PePg0lhfi70/8xqJiSQmGN7iNvT9aPLYqaKC7GNzMtUoh8bOkWRypc8c+AWYD/cCSn
         450Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791740443; x=1792345243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zvh6uQ9bGzCwbdbYbC1n1+7RZUsbZpcs8nWAcUfwSlg=;
        b=P0n64nInuQ1zassGulUPLdBIpZU6u6mJTt/otktU4VYgiDPjNPQ0Hwa76781CfX8WK
         MBZ8zMkJKxtIdSsIKUKlk8bzCkdyP+3aqtJqsOg424RQNh3fmR2UVWk1v1rz1linGfsz
         X7y8VhH1pxpRm6zLI88+SWYDQnWb7CfTwld74fs7RNTEcKmZpuVdsG7NYMsJTfxVm3JM
         pkQvWF/lHcuWCQXbIkxvFxvmOo+ulxTCtYVJB5vZeQUnREFSohrzaPw1LjzR8vExpi4s
         zTG8q5xPvoaUrWLB31Ro2vZeKy3dsmbinGjCPAH4k4j1BUcLef+QsjffCoOQ9DvaiQOj
         RDMQ==
X-Forwarded-Encrypted: i=1; AKwUvBwbCI7sXbHKvyxYWRPfnGwRr0Nk8iMrmfKB2AJGOSRV7oqU55xAV08Le6N9gYFeEyy+/0l2vOu8YZQ=@lists.linux.dev
X-Gm-Message-State: AFq9FYKm9GiCGBIYziebcbNVJlvqzPVm3OtzfG46DYheyJ7NEwv69u4I
	6Oau1RaKl5A9H2xbOiSWm096f1/p9biPDTIyb++HbEHJssZ5rgBVhgMv
X-Gm-Gg: AYBFou0cCH8MkHl6PPfNPkZgG8sOw4iQbQhC8teApePV7389D7cam1qSD/z9mSKQuN6
	feLSVYBVcvm/I5nCJy2JTDP/Nr4LpjV5MnqxFhXVajh4mRbpdqimjFF6sBWoImIJIHD/AhgbsC0
	9CvkW9hwD7BAOOjNvRSzlujozbA9PMRH4dLotC/qOssDuWVvlGV5zsRF3Z64ZV80yaVyhR82LUO
	VnvsHb6xdPwplmFoD65dmqqxCfgoTexzrmJhXLPTKx/HaS7MV9xQs8QZu3vaJprvPlfx1kFR8Jl
	BIDMZYo0YDMXeAXfSCNp+a25wKpv/9Vs3HB+C2fRs1o9hwAhw0Prfc5ryYiwc5SDeTRK0YPc0ny
	ll0zqy2BceX90JwOg7IRF0Nbff5I1yjFNt6Hq7EEhDCnq3pKsYbdaBBU/zSr6u6q/82f5PQF1yH
	W6WEmgxB3UpurryJ8IGnZJEjOJK24mJGOTj7AglZCbfx1jMChoZ+VVKUzm55rF01/jsautk9uez
	bMQ2+19k1cQKmOGnrBu
X-Received: by 2002:a05:6000:46cd:b0:487:10cb:ac16 with SMTP id ffacd0b85a97d-48dbaade0e8mr7581774f8f.4.1791740443065;
        Sun, 11 Oct 2026 10:40:43 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9463049sm15688482f8f.4.2026.10.11.10.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 10:40:41 -0700 (PDT)
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: vincent.guittot@linaro.org
Cc: arighi@nvidia.com,
	bsegall@google.com,
	changwoo@igalia.com,
	christian.loehle@arm.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	kayracizmeci@gmail.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	pierre.gondois@arm.com,
	qyousef@layalina.io,
	rafael@kernel.org,
	rostedt@goodmis.org,
	sched-ext@lists.linux.dev,
	sshegde@linux.ibm.com,
	tj@kernel.org,
	void@manifault.com,
	vschneid@redhat.com
Subject: Re: [PATCH 10/18 v2] sched/fair: Add force push task mechanism for fair
Date: Sun, 11 Oct 2026 20:40:38 +0300
Message-ID: <20261011174038.5334-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAKfTPtCAbreGDhesDmFNvXEzjj+anmOH1=jqT-1B6Lfj0FfPqw@mail.gmail.com>
References: <CAKfTPtCAbreGDhesDmFNvXEzjj+anmOH1=jqT-1B6Lfj0FfPqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> >
> > On Fri, 9 Oct 2026 at 07:53, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
> > >
> > > >       task_tick_cache(rq, curr);
> > > >
> > > > -     update_misfit_status(curr, rq);
> > > > -     check_update_overutilized_status(task_rq(curr));
> > > > +     if (!tick_pushable_task(curr, rq, rf)) {
> > > > +             update_misfit_status(curr, rq);
> > > > +             check_update_overutilized_status(task_rq(curr));
> > > > +     }
> > > >
> > > >       task_tick_core(rq, curr);
> > > >  }
> > >
> > > Hm.
> > >
> > > I think this mechanism added on here does not works.
> >
> > Ah yes, while factorizing the code, I removed this main diff between
> > tick and put events

> In fact this is on purpose.
> fair_check_pushable_task() is the function that is called to decide
> wether we try to push or not a task. In the case of short task, we
> will not push a task that is already alone on the rq

I'm confused. So, is the added tick push mechanism not working at all
on purpose? For future use or something IDK.

Before the fair_check_pushable_task call on tick_pushable_task():

if (rq->nr_running > 1)
	return false;

So now at the rest of the function, nr_running have to be equal or smaller than 1.

We call fair_check_pushable_task() with next = NULL.

There are only 2 paths that can return true, one of them requires next to be true,
so it never works. The other one:

if (check_pushable_short_task(rq, p))
	return true;

And check_pushable_short_task() does this:

if (cfs_rq->h_nr_runnable <= 1)
	return false;

As I know, h_nr_runnable should be smaller than (or equal maybe) to nr_running.

nr_running can be 1 max, so if h_nr_runnable can't pass nr_running it will
always be smaller or equal to 1.

Maybe I'm missing something from the start :-)

Thanks,

Kayra

