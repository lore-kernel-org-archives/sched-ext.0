Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C712C08D9
	for <sched-ext@lists.linux.dev>; Mon,  5 Jan 2026 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767637355; cv=none; b=qJ8JhLwdDC22jliPRO2L2XKs0sUZyqFmOkG/5xLH/vmBE/3Qbz1VxD6930HgkstVhBVaD6tGlWxfPDK0eUVNyJYGStMGON4c9NXPmr9zm9b2RyNykg5Kgq4/F2q29gZQuttFyJ9KifYLzU95ESVr1Ts9/8oZfRi5ZsKF+rP9YcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767637355; c=relaxed/simple;
	bh=t66+7KOAPUPEKD/IgPT6Ru7OImztlruilpFCWBeGF8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYlrgljIxZsZmqdU8dH4iqnuWdh7xUsxBZq4iFmwcUUGH6D/8n/vgLuAVfzBK3zXg+ASl+9xZquI9Si6v61Xz7GRpeD/mrKjx2Ks8OlExZ7MP1tODXF5YUqX28WVRw3YFh0cyZ1L1Xx2xxTUykqHK0rlvhXjTSN6e908bieL6+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3v75Vej; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3v75Vej"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DA5C2BC9E
	for <sched-ext@lists.linux.dev>; Mon,  5 Jan 2026 18:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767637354;
	bh=t66+7KOAPUPEKD/IgPT6Ru7OImztlruilpFCWBeGF8Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H3v75VejZiNrQbIst6HHnXoO52ZM3Tx8ntiu3O/Msz5wcDsrWEc8ezPVnk8ri0yd0
	 Rh4pTt3Y1cWmiQ+8Zqz8DMt6AS9L5KNl2AoTVCpLRVC55oTfl5yxL1WaxTN89d3qFI
	 4nFGjxtFGBe1jeg5Zz2wK2BVB6yaLHaoFWgmC6b8QqTukyRg/VwujlzdlcSCcxeb2K
	 IAyF4kf3P4BYFZzngnRRpQgVrJOLagl7A5Vb6d+TwEj/biXuDn0GVZA7P5PUbHnjDv
	 153+Wyzg1IPiPc0lh5P84q+BSjuuAd9Fve1sNFowy8o9tn9TdtW2/7wqYzOeO6rg+D
	 N8IFIInNNFTgw==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-65749fe614bso67199eaf.1
        for <sched-ext@lists.linux.dev>; Mon, 05 Jan 2026 10:22:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUG/mFSiRfjRkOYiPPdRnldKhVQAiRW6ZLLc5JbY8nLTWvw8SwqEBd5l7ZasvCCaHDUaQvUHARJQTk=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+Tvb1b/UFquAxLqUsjz3X6rQjQYOKppiN14wEAGd9sh8uwjzW
	l1r5UyrN8wzUzmr+1f3HS9b6mMLfalTj/b0unEjbadk8yQXNvvtENjCFnDdzYoJsF5L4J6qC0k2
	sW1FTunWOvElxWni2EmeKK8Qg0D2QTTw=
X-Google-Smtp-Source: AGHT+IHB172ZQGOi9ZR1u9PjyV58cNhnXMvGGbP/9JKsqng7N5nz0M5cIctutXbciJi9XeHJlW5h6fuqEMIqm3oSi7E=
X-Received: by 2002:a05:6820:7802:b0:659:9a49:8e74 with SMTP id
 006d021491bc7-65f47a463d7mr130879eaf.68.1767637353760; Mon, 05 Jan 2026
 10:22:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251225040104.982704-1-changwoo@igalia.com> <849b576e-9563-42ae-bd5c-756fb6dfd8de@arm.com>
In-Reply-To: <849b576e-9563-42ae-bd5c-756fb6dfd8de@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 5 Jan 2026 19:22:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0imU_DkW5-Pip3ze-MaHj+CAvc0LNkaLsTZuFbj33R0aA@mail.gmail.com>
X-Gm-Features: AQt7F2rIqrdl4_Lfta-tfUzoW3gXGzlizLu8a9j9KJ9CU01qQlc9bEEV4GjzNSk
Message-ID: <CAJZ5v0imU_DkW5-Pip3ze-MaHj+CAvc0LNkaLsTZuFbj33R0aA@mail.gmail.com>
Subject: Re: [PATCH for 6.19 0/4] Revise the EM YNL spec to be clearer
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Changwoo Min <changwoo@igalia.com>, kernel-dev@igalia.com, linux-pm@vger.kernel.org, 
	horms@kernel.org, pabeni@redhat.com, rafael@kernel.org, 
	netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, lenb@kernel.org, 
	pavel@kernel.org, donald.hunter@gmail.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 10:44=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
> Hi Changwoo,
>
> On 12/25/25 04:01, Changwoo Min wrote:
> > This patch set addresses all the concerns raised at [1] to make the EM =
YNL spec
> > clearer. It includes the following changes:
> >
> > - Fix the lint errors (1/4).
> > - Rename em.yaml to dev-energymodel.yaml (2/4).  =E2=80=9Cdev-energymod=
el=E2=80=9D was used
> >    instead of =E2=80=9Cdevice-energy-model=E2=80=9D, which was original=
ly proposed [2], because
> >    the netlink protocol name cannot exceed GENL_NAMSIZ(16). In addition=
, docs
> >    strings and flags attributes were added.
> > - Change cpus' type from string to u64 array of CPU ids (3/4).
> > - Add dump to get-perf-domains in the EM YNL spec (4/4). A user can fet=
ch
> >    either information about a specific performance domain with do or in=
formation
> >    about all performance domains with dump.
> >
> > This can be tested using the tool, tools/net/ynl/pyynl/cli.py, for exam=
ple,
> > with the following commands:
> >
> >    $> tools/net/ynl/pyynl/cli.py \
> >       --spec Documentation/netlink/specs/dev-energymodel.yaml \
> >       --dump get-perf-domains
> >    $> tools/net/ynl/pyynl/cli.py \
> >       --spec Documentation/netlink/specs/dev-energymodel.yaml \
> >       --do get-perf-domains --json '{"perf-domain-id": 0}'
> >    $> tools/net/ynl/pyynl/cli.py \
> >       --spec Documentation/netlink/specs/dev-energymodel.yaml \
> >       --do get-perf-table --json '{"perf-domain-id": 0}'
> >    $> tools/net/ynl/pyynl/cli.py \
> >       --spec Documentation/netlink/specs/dev-energymodel.yaml \
> >       --subscribe event  --sleep 10
> >
> > [1] https://lore.kernel.org/lkml/CAD4GDZy-aeWsiY=3D-ATr+Y4PzhMX71DFd_mm=
dMk4rxn3YG8U5GA@mail.gmail.com/
> > [2] https://lore.kernel.org/lkml/CAJZ5v0gpYQwC=3D1piaX-PNoyeoYJ7uw=3DDt=
AGdTVEXAsi4bnSdbA@mail.gmail.com/
>
> My apologies, I've missed those conversations (not the best season).
>
> So what would be the procedure here for the review?
> Could Folks from netlink help here?
>
> I will do my bit for the EM related stuff (to double-check them).

I think that it'll be good to have this in 6.19 to avoid making a
major release with an outdated EM YNL spec and I see that the review
on the net side is complete, so are there any concerns about this?
