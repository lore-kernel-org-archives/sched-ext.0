Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974E0218592
	for <sched-ext@lists.linux.dev>; Thu, 29 Jan 2026 11:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769687323; cv=none; b=Itfo0sVN9px6nx47teWlHilmPmDmxOXGMwU4o/qdPbhHuKNvMIfQ/uG3GLY89M9xBQU/LCAG7+owqRpuvZO/GMKy7gLeLE38Du9Kd4CXgZsgnQFabZYTBe+k7l7osgDbs1RWcFB80PBjtxrP4gaB2mw0IDRlbF/jgKv84tnZZrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769687323; c=relaxed/simple;
	bh=1MoxfuF7Dr9DZ2W692sCILfpQU+iiHBYS7PqvXUbmVA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKFdypKeEwjoJG1JDzpP2Ef1sXhJG7eL8icsZ3dxecd4Q9FTrqy6WlpxpF60VjzVZT96pSi5VRZ+j6oWds9Mn6651q/9tzuGhiomjiQs//ITMxsaP6t7Ii2DOHLZ/BW1P1HY2dKyVgaCQYoTn8SAqW34T1ODGOGdh2+pNCEuWVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y0B4DdaV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0B4DdaV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769687321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1MoxfuF7Dr9DZ2W692sCILfpQU+iiHBYS7PqvXUbmVA=;
	b=Y0B4DdaV+H0H7UidIgfeRw/xJQq39RULXMx330uE4wpV+dl5xmenJX0gFox0j/G3Quet3D
	DuP0T7Yd35k1Zwq0YQzFgbD2i+jsLs5mNfKddgseIZoVTkoYZ5dj6gmlsSOd2YLLrLUvQC
	5UPi9Ojtj8lP4r5036CxfC5pH6ITIbA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-mB5SWCwdMCuowQgYcBwi8A-1; Thu, 29 Jan 2026 06:48:40 -0500
X-MC-Unique: mB5SWCwdMCuowQgYcBwi8A-1
X-Mimecast-MFC-AGG-ID: mB5SWCwdMCuowQgYcBwi8A_1769687319
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47ee3dd7fc8so8556255e9.3
        for <sched-ext@lists.linux.dev>; Thu, 29 Jan 2026 03:48:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769687319; x=1770292119;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1MoxfuF7Dr9DZ2W692sCILfpQU+iiHBYS7PqvXUbmVA=;
        b=rZlFjaruNDA4bvCiYajiW3s2iE0qJ/IAkmSJ19enuTOtg0qURlIAkPB5eZDLJX8xzs
         CHUYenJM/yJP4YSx6OlAPlc9Aefbu99bptNi2W7WryJfJ5LPT+p0SHqXaCnCBOQOkw8b
         nnwJH6zUeEI8naO8WJUN8NzqCTAtcGPuGj5uoSmBuDjjwmZYAGWWuERq4f0MGubLVWlN
         aOdQDO7m/eEhtGAvaAZ0PSmFeFs4XMkTzg7dyfHgRfwoz7I7I0Ffk/0vV29HPH/AtLg9
         +MZwvHy9EzPmEcY1KXuaSkpnGwuhcjZNzalRSEXxeJIuZSmUN9skA7ZN2AI6MnEFC2q3
         MsuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWMg77CCaxDAGAlMXxVJfU1sLIyyvhQtq71TmO07XPLDFkyKtrpfH/vkzCQermIOxG3i+Jx3uaWxI=@lists.linux.dev
X-Gm-Message-State: AOJu0YwwwghpjnQVJnuQBuZVQvgIF41UBRKFHiMB/LKf/OYuATf1vXjJ
	qXxqV6V3pKuVrfQs39VTPJVxSqY0Ky8q5plkaQpmSE7WVqqwfe0R2EFhuq/+NPULsKeDL91KDLT
	zUx9wpmCmZdjzebuBaMkes4bFOwBLvCGv/A+vimc4Nds7CEgo/PhC0NxM0xXjoA==
X-Gm-Gg: AZuq6aK1oWdnEJTf+42G8E02FKMwk1VzM6rCUplQwCZw/zvwwY0vLDOB4VeQZgcBfs/
	jqQjLtgrp1PChixjC4mxZgoJ7+ziwMRm/rR0bDOTvSWS0XUHaPWJhm/fGdBEG7xwHF30/1hjs9v
	kl0Xnxo6b1YXNYddnTdQtBPluIqkg9RdfoT9h3UCdLrsxXH0tZVQtv0icaa8ShvipahZZdJDSSI
	t3KKeWiKIhJQZ+Kka/4cpR1bt0kZDGLHCeZWJMvEOL8hP0w6KgSPu0q+dKGI/zPJDZVgPEW7Lk0
	MqkaB+C4F31dndc1fA3wWxeaJmV0edz0+A9Ydc5T90RkXZ7AWA0IUPHVKD/YgSlWdo0EigZkVy6
	ZObixD/U0X8/DHg==
X-Received: by 2002:a05:600c:c0d1:20b0:47e:e952:86c9 with SMTP id 5b1f17b1804b1-4806d54b5b4mr62281845e9.0.1769687318880;
        Thu, 29 Jan 2026 03:48:38 -0800 (PST)
X-Received: by 2002:a05:600c:c0d1:20b0:47e:e952:86c9 with SMTP id 5b1f17b1804b1-4806d54b5b4mr62281615e9.0.1769687318525;
        Thu, 29 Jan 2026 03:48:38 -0800 (PST)
Received: from [192.168.1.166] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-481a5d55d3asm594825e9.6.2026.01.29.03.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 03:48:38 -0800 (PST)
Message-ID: <b7ffc7e6121320d29cedcff0e2b68ad76c8e2775.camel@redhat.com>
Subject: Re: [PATCH v2] sched/deadline: Reset dl_server execution state on
 stop
From: gmonaco@redhat.com
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann	 <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall	 <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider	 <vschneid@redhat.com>, Tejun
 Heo <tj@kernel.org>, Joel Fernandes	 <joelagnelf@nvidia.com>, David Vernet
 <void@manifault.com>, Changwoo Min	 <changwoo@igalia.com>, Daniel Hodges
 <hodgesd@meta.com>, 	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Thu, 29 Jan 2026 12:48:35 +0100
In-Reply-To: <aXoSFOONWJmdyCQB@gpd4>
References: <20260123161645.2181752-1-arighi@nvidia.com>
	 <f99f63b4a777ff990832a27fa6d171aaf1206a75.camel@redhat.com>
	 <aXeWnzI3ymUSm3Cu@gpd4> <cc33e6e3-3ffe-4ebc-a2e3-7dd7afe13538@redhat.com>
	 <aXfcGynN92kyw5Co@gpd4> <9b8c90b1-9247-4159-9bf6-72bd71bb74a2@redhat.com>
	 <aXjJG-72XEqvaVtL@gpd4> <be763631-f677-4bad-8285-69dbfe29db54@redhat.com>
	 <aXkJ8_zLVSuToLxe@gpd4> <45e4dc7a-f261-46ec-8973-0fb8d1f7b0b9@redhat.com>
	 <aXoSFOONWJmdyCQB@gpd4>
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i-JAwhrxAaxFFvZ1GEhIMpmpgBjVOpvounyRSgKgWSw_1769687319
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-01-28 at 14:41 +0100, Andrea Righi wrote:
> Just to make sure we're testing the same thing, I'm currently using
> https://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git,
> branch
> scx-dl-server.
>=20
> I'm running this test inside virtme-ng:
> =C2=A0 $ vng -vb --config tools/testing/selftests/sched_ext/config
> =C2=A0 $ vng -v -- tools/testing/selftests/sched_ext/runner -t rt_stall

Well, that's a fun one, I could reproduce the same failure you
described in vng on another x86 box.

The arm box (bare metal) I used initially still passes just fine all 4
iterations of the test.


On the x86 box (vng) I tried different orders of iterations (where the
original is fair-ext-fair-ext) with and without the ext server active.

No ext-server: the ext iteration fails and breaks also fair (unlike the
arm64 box where the fair was intact)
ext-server active: a sequence fair-ext breaks both (like you observe).

I don't have time to look further into this right now, but it looks
like an interesting pattern.

Thanks,
Gabriele

