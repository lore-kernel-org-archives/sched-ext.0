Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DA23B71A9
	for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 23:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783727031; cv=none; b=cMgaBw+46dYSZunsVe/GvHfkzoEox3HVksnHEcZhYS4Te8s3H9a1mpx7Oet4b4xoBjyf/i5tdmlXPcgbMZ8UntOOV0l0u54wN/ngiBBZaIekZD2Th9TNOdqQ+/kzNoiQWm7WnI6sJl77Ts1VmamqXDaugrCZDbwp63A7QLNb0dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783727031; c=relaxed/simple;
	bh=PK5r5CSk1B7XeUp5Kcu4wbVddW3ItH3De22ETA07fPU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Esbal1BCGTmdOdnycYk9faXC7DGNAdwlWL/qvZuTaG5KcRt0zlzXe/kJOuNBOJHYnkc7OmdDIOrVT6Elv6ofw6DuSdU+nSxUdXwotj9USqWuVAGRG+zRIGczKX5nBuMdaneg+zT51x/O4jxMZtpmvC9y6yIUf4v3MV3z2MuNwyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=avs7LDj9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="avs7LDj9"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ca64c3ce5fso17529735ad.3
        for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 16:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783727029; x=1784331829; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PK5r5CSk1B7XeUp5Kcu4wbVddW3ItH3De22ETA07fPU=;
        b=avs7LDj9NiQXdBRUeSaSxAamIKy0afKmLNjPYYtDN7C9HgrhfuU+6FGLPlCyRwOzWW
         MEUFPuBZo3gzMruNG0xTicRMwoHzu6UgUaZp7rCiE8eZt0nJvP1SZTb2VCu6v7o1ND0M
         h+NErxLsK4WoNOKv369zNIVH6+0U1opAyTMJQwdO0OjXscsP/nRK++u5hxMO0pkVOQR2
         MGFUmMQRQSSa8RB0EV+WKDgyerL6diG23mvpArgiaCXMK7vnqS5rrt7mcsu6PpYS2WeZ
         4nLyiqXu2DUpJtfPLGge/YVKUFTiJsOaaCY86d1FyHqMejKIVFkryhRpUQLXw9VFMOYl
         2yIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783727029; x=1784331829;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PK5r5CSk1B7XeUp5Kcu4wbVddW3ItH3De22ETA07fPU=;
        b=PAAxBqXmyf26V6JPZUawr6qdu21pg0YIarIFyFgpL+3aW/BYQ+DJNmVnkewplcofPg
         ewTAeVuGv1Cooa5bGKmFYeA2LkB16wJra9bsyNg46GSauVXAtrXYMKyqDM/wlZtSbfWK
         /zcmMoX5ww2kkU2h36z3C/Hykt8pfuH3O8arv70j9ZvoHsV6HYdQ6IB5Y6cHSfM69btw
         wjhxsu2bJw3Wr59n15xBSi3GYAmzqAdynKqgW/xkMMoL6czjCNoX3rOwrDRTFKNMXmwi
         XBdq10yTn0BvmLr5+uHKKHX+gUwN3hovVjEyMUSyCx4TCUSXGv3+rCecdGcOPVjxkgeN
         YkMQ==
X-Forwarded-Encrypted: i=1; AHgh+RpqBIP4/G4YLzo8i4+E1gnVJF6khrIOm3CNrybNnj1Zp4gNu3AX4mDIsqGfnn17wjFnQ55GvgMQIWg=@lists.linux.dev
X-Gm-Message-State: AOJu0YzREtgfJJMX7DjZcsirq2v+wMbuwm+PqARL1+XN1oMhw8t4Ogyz
	5kCVXqT2XYcB2PJu6G4S5BY1N1gPMTGSeIVpZIcCc+3vc9AT9IXoUiokpqElnf46FBU=
X-Gm-Gg: AfdE7cnYbrtpRvoZj09hC0lvq/7KwskSL3UnjmGEstAnAEYJ8mVgcmaKkK0y40BvTJo
	67x+jKh03dcy1182yFUIrYXSU+ZxTrQitg4//ELQ1+m1TvttD8qYFQXvdPEizlCPERvWLkn5hIO
	gBl94c0LKBiUewLX/vx8LGpj8iAWZ3NkqxZLTl+/Dj2dZCU/ujkY0wY/lmzx5NlHFWozv5IokYT
	ZLs6Ci4rW/3t+dTEw+ujPlb2ajgSlrvr7bAHI5QUXND8BbhzpNO7PCeOl759EjC1Rtlvvs3mn6A
	lgsLkI3t3quqyKFWBMEgA1VMtVwVxJ+OR40CP8DO//bWlYqwQff+BqZ78UT2nqAA5UOXIRvVn3L
	OEdoPMjr+2aJfk4FudCIOL/F4OgWoANeDHvxPNs4EhTBOXhF7U727P5+Z169bqLk2gAC3EA==
X-Received: by 2002:a05:6a20:d489:b0:3bf:6c08:fba4 with SMTP id adf61e73a8af0-3c110ba29f4mr1116014637.56.1783727029145;
        Fri, 10 Jul 2026 16:43:49 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::6185])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b9ca880fsm4980155eec.23.2026.07.10.16.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 16:43:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 19:43:47 -0400
Message-Id: <DJVAGK2ZNM3C.HAVUMJES6MGY@etsalapatis.com>
Cc: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>,
 <sched-ext@lists.linux.dev>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Require a BPF cpumask for
 bpf_cpumask_populate()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Admin"
 <main.kalliope@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260709182800.2037938-1-main.kalliope@gmail.com>
 <20260709182800.2037938-2-main.kalliope@gmail.com>
 <20260709183918.E42371F000E9@smtp.kernel.org>
 <DJV4TO9OH6AN.58C10SBPE8FF@gmail.com>
 <CAJZwKki8MwOmij3JZK=KnnO0hEUuxWA-iY=GK-TtvtVRvOkjOA@mail.gmail.com>
 <CAP01T76KdhEsbZj8yZN-yg5ogx99Ud87qqrhOGXTrX1ALdAgyg@mail.gmail.com>
In-Reply-To: <CAP01T76KdhEsbZj8yZN-yg5ogx99Ud87qqrhOGXTrX1ALdAgyg@mail.gmail.com>

On Fri Jul 10, 2026 at 4:34 PM EDT, Kumar Kartikeya Dwivedi wrote:
> On Fri, 10 Jul 2026 at 22:17, Admin <main.kalliope@gmail.com> wrote:
>>
>> On Fri, Jul 10, 2026 at 3:18=E2=80=AFPM Kumar Kartikeya Dwivedi
>> <memxor@gmail.com> wrote:
>> > Once this lands, please send a follow up to address this.
>>
>> Thanks. Patch 2/2 covers this, which updates the cpumask_common.h
>> declaration to take struct bpf_cpumask *, drops
>> the struct cpumask * casts from the existing populate tests, and adds
>> the borrowed-destination rejection test.
>
> Ah, my bad, makes sense. Let's just wait for others to ack it then.

Patchset looks good to me, and is consistent with the "mutation requires
passing bpf_cpumask, reading requires plain cpumask" throughout the
file.
