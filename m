Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896BD28726E
	for <sched-ext@lists.linux.dev>; Fri, 17 Apr 2026 06:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776407440; cv=pass; b=Wbki2JEhgVuCDprOeBv87UrcQ4l3E1WGIRgvr+DySmrAb/G/IonM2FOzfVkRik6W3qfkTeRMLd8ewF88xailufsmeTM6Y6AmnW1GmxKUuX9X9Z+bvrCnK36NcNqC6Koqmc0lxPK1rg8F8dqmqI7RL23FpqcQx0eo5avub6+FKi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776407440; c=relaxed/simple;
	bh=eQjf63Fv03/lLp1JyzRkc1/XN3bTfq1vV7Et2P8WcaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHb6M2MjeX0IrHwV3fTu+8BHld1wxZeOQdjxqs+0zR3gfkJdKaIoLfp/U7TZVxbSQ5y4dlapndip2cxNxFg8Bf7CLx/Z/6ZJqlSTaNXdvL+ikk5q0BtaVxFFUP5sLbFy19GsrlOwO/4WU9lV1+8rTw5IvojqcUVJBrjUwYpxopw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPGh0TKK; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPGh0TKK"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35fc2b18363so419059a91.0
        for <sched-ext@lists.linux.dev>; Thu, 16 Apr 2026 23:30:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776407439; cv=none;
        d=google.com; s=arc-20240605;
        b=Pk0jPphRHpXqGnkZII4s3pFFmWozZSJgwWt/qdWdric6m+iSyBZxa3UGnodL4ql3HB
         PD/bofQoglRyVRaJ/Zr4SI6CzJZ+y0ZiQrR8s5Qr1yJvwQ6kpKpaUZ9m8j6T7DmFz2Yg
         jHiTsWfqkZIis0bNB0H+mQ0grGBAhsB9m7PmuP04h6p9jy4Ix9UE7QDyzxnpjTux9E0a
         BrJRZEtyiGOfmn8OUcsOEfxscgmm/gNUtOl5+CoLtU8mQ356i5mh2NJrkBL1A01gkjDs
         T1lgHQuyehRwtmjw+whA6gQVYwr5KS1ZGOtMnKnMPSl17egYAi3L/pn3AccK2Odljf+t
         Bq/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eQjf63Fv03/lLp1JyzRkc1/XN3bTfq1vV7Et2P8WcaY=;
        fh=8Q10VOSeG6fl1GOpCB8fDmw9zRjxf/Nelf8LDpk22YI=;
        b=dy/xFniCHvxwQORUkiCEuVoBQ8QIU/2fOitr6nzVvfTc69Dxk3z5urNbLywcm1TH8x
         FG905Hm1+ikfJtbNc7jTQ2v++ixDs30HRNxg37dXbaRHGecREoI5Bkix/DcyL1NELMnw
         iI4rsp14EcarFOyR2AUXUfYwBOPvVd5+d7zv2bklFeLPsoaI84y0ilT1OzoRMlsaB+j6
         a56utkVfdNVeWP7ubSFTLT6l7gCuMSzjCqcKJLZSuWhrVQ5KEm75tyBqJA3+eO4x7aae
         GHs1sG8ah7x5qbhE010qAv4FlEDpuYj+0dLQ/bsapD5A6TOCfy/7yWa4wiZVIATrBeDX
         LqUQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776407439; x=1777012239; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQjf63Fv03/lLp1JyzRkc1/XN3bTfq1vV7Et2P8WcaY=;
        b=jPGh0TKKfwKfiwv8d6O4zwDYNswCJ8zvKbIwNVytT6vb2yP9bpH3qwkS30SVq+Un3g
         Vwe3XG2QJDejSra00hbaf6CFNSKZ8HAPqCFwFe2LLGkkkblW1n1X7bo91VcGnp//Zgs2
         j1wI0fES3b42sEkxNhzWbmXePNIhZItETTx7mLUc+0ay4NkTzHIuqSy1Xidx1wb8TTD1
         Uxz4+62q8ncSxxvA38F56AzTgTtBnBwLyH95nSsEOxywlRFWIgCVJosY+pziRYSBf92F
         keA+EMEppjZzG957VyClKgSKd1g7xiIq1Kp0yERrOWW1WidpzRHTvr0S4yAd+wJRH3Sk
         o5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776407439; x=1777012239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eQjf63Fv03/lLp1JyzRkc1/XN3bTfq1vV7Et2P8WcaY=;
        b=j/+cPkxLj9KrOwFglMxE9byuZMTvDxEjrAg2SU48CgN3pArl2N89+BmXYI6qAxSexK
         NVHZyg4q4S4qU56TPziC7Lw0ah4TjH5F5RiLPGC+Etifs5Juo13TPzrBfZcqWsW7KCBX
         vhKzlJZMWtm1qAxEVf3JQ34SHW8FK3bczbTQx4QpPcVSfQnQrz+N4shigZZP+UfmgJy4
         ghYH2M8mZFygT3Xi1XWDFOwo+/jpBrCKlcMczruiXfNbjW0Ni6XNxyu1NehQ0muFzPOh
         J29WfcUGqRdik1dz9i8zRka7zXwdVpSs5pybA3dgRa/R8te6VB4cJbVHAK50YO8qS3Nx
         EPtw==
X-Forwarded-Encrypted: i=1; AFNElJ+iXYbMdafQTnAqvgTcST768JL6EEnIlWGxvTT51NEbm7Uq0N00AaRs1mPdMFmKthpX7EAm/qwZizg=@lists.linux.dev
X-Gm-Message-State: AOJu0YwXI8leBQk2vFFQNgWS24egpt7H6iR0OTZ7ahV4v/MO5vVIRGxN
	KEC2xFa7Fs6GP6XQo37+wGopMF/f9AR5jFywQzkmt9sfS1wV73tDczEV/YmfQv9FU1RepjSGaoB
	t+ig4jcQnVOy0TeApQiDswQMSb1sEMec=
X-Gm-Gg: AeBDieu7JS8ubroRZ1Yj14SWQyvd3keIaat7q1q2k31QHVAL07hJtVSxrD0QV2eBceF
	LNuDJn56ABf/O49bI3tRUgY71wiJ7ZKEXKBHWJeGadg0vNcXKHD+dBPId4eGMnlauAl9DLy/Vkk
	mY2AcIMjqXWJX30D0uHMtekfTh20DYYqk0YxWSYQUzaNcEPCbLqJ4v/f83Ns/oMldL5gLXV5K/P
	z0iD/83OHGz+lF6mo1bkdOD0j4rqqmYlwf8x5Eq7Mpyuf24fygJRj9Dt05uz2XJSosiXs0u0aBg
	J9BPwpIHDv7eLna0G4ygYOvCklmQgYXsrzRWekhoBlDT+ggWtg==
X-Received: by 2002:a17:90b:1dc2:b0:35f:b306:5d47 with SMTP id
 98e67ed59e1d1-361403af9c4mr1787310a91.1.1776407438810; Thu, 16 Apr 2026
 23:30:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260414125933.3520885-1-fredrik.b.bratberg@gmail.com>
 <ad539mUd8A0lDWAw@slm.duckdns.org> <CALP2E1xwgfNmW+u=oyQ6bVW0ZeuQRZK65gR5RXyQyzy1n6U_8Q@mail.gmail.com>
 <aeEjhTftzK_sjYi-@slm.duckdns.org>
In-Reply-To: <aeEjhTftzK_sjYi-@slm.duckdns.org>
From: Fredrik Bratberg <fredrik.b.bratberg@gmail.com>
Date: Fri, 17 Apr 2026 08:30:28 +0200
X-Gm-Features: AQROBzDycB-ddt_eDK_taw9Z2FZr9wIEEwxZPEGnQIUgQQDiog8oYYhEX0pTcXs
Message-ID: <CALP2E1wVZS-mRo3-Cdp0c0D0GSqv5rK-w2D3T0_sFXgwAg+AbQ@mail.gmail.com>
Subject: Re: [RFC PATCH] sched: add CONFIG_SCHED_EXT_RT_EXPERIMENTAL to move
 SCHED_EXT above SCHED_RR/SCHED_FIFO
To: Tejun Heo <tj@kernel.org>
Cc: Henrik Austad <henrik@austad.us>, Peter Ziljstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>, linux-rt-devel@lists.linux.dev, 
	sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 7:59=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
> In the current form at least, I'm afraid this would have to be carried
> outside the tree.

Totally understandable. Thanks for taking the time to explain and review th=
is.
