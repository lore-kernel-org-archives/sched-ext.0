Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBB43603DD
	for <sched-ext@lists.linux.dev>; Sat,  4 Apr 2026 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775320852; cv=fail; b=GTb+yi87AI40E6RqkggP4QZyLYOtfam1eVB0K63dF3n2X/rY2IUyZHhf3G0nBemWuc7HnNYC4AbGsmqYeBOkuH+S9kON4UjsPIBV4qMQk54dts8J1mE7+Ueu+tci3uBsbxbbbZwZUZyrzhmtwIGc5umafTcm0vpZ5UOhaZvRaDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775320852; c=relaxed/simple;
	bh=iV37qvbVyplWi7Jba6FgSMvymwCKnsHSzZZ82XglO1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKebKei5Y3ofmJoRZMnfl/U2SpfCND6NOiIVbFX0m8uKrtDUWXC7heK0Hy/cLIKtgegLLEeeVlBn7nt4qkgA7a1K+6gpLUVdyYu3MHAgoQ8QAeuBS3etsBvRh4BQwGqe2VCja8LhbO5+WHlPzFL36LjyCGf/WF7lUHEu9ruB97c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VXxYYEuP; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VXxYYEuP"
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 634CxUcK3806227
	for <sched-ext@lists.linux.dev>; Sat, 4 Apr 2026 09:40:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=KwRHdRHc1911uEdrI9ZLUxY6AlxSrXCCFHI3MngWm0Q=; b=VXxYYEuPuoWG
	uCs3BMlrP0qiMfbah1vivv39DibsWp2PQb/8jXkHJwh2/t+WM6mxIWcyqKozcxLb
	UN4hD3UQyPBmDuSwFZCobmD2aJJCbLMBgxITzvA5jXPBlFdDzbrwG8ssxuapsIDX
	8Snaolm4sptfZwk6K7JX8+ODtgh5BEvENl9AprUciwcM8+gXG2M2iqC2LGluDwh5
	/H2p+0F/TBQu3KGeXLtZ9qzR5EDdgqSR45I14WhqKzvor9/E2FdgTzeGQy4p51jS
	gFeJhO9AOrEFt8bd8kPISEPfSCN7Ppb+jwX+uk2BqujOWmLiuq7egIpdcXiFF2tu
	NZyYKWXyZw==
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4d8pxqqcrf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <sched-ext@lists.linux.dev>; Sat, 04 Apr 2026 09:40:49 -0700 (PDT)
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d177fb157so2563632f8f.0
        for <sched-ext@lists.linux.dev>; Sat, 04 Apr 2026 09:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775320848; cv=none;
        d=google.com; s=arc-20240605;
        b=MDQmRnyv8Efb9IN624e6VRogkxq7KcysyKzGEo0Oaj4IHS7rqakEFIpSmoh4z0Bn1G
         SnIgrZr9ze8AULSDZayJ9zwca6HXX8Spd6LoBhhT2RzrnPdUUPCdY61maUOfaamtNdGE
         6fRhnAgqMLf1aUMbmb7Fub6XbXIQWyBcz+bkIR9J1xLRiJdfcx7aEWZriRghu+R/oU6q
         /EpP5fc4Hj1c49RWdnWuoYF14maPMhcue4cUgwAssp3oWsk1mXWa4gl3OxMY/Bn2VPNh
         Rd2Nq+kGBJTrcI2adnpQOV2iu0b9bLm/VqJvZMk1mSlLmJT8/wMlYF+YGgCv0CSKro6z
         xnEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=ZgA226Cmm4VCqAdwuhHb2i0vnYsqVsFbxRKzFOanx3U=;
        fh=g3U6xD8mvE0xg9an1R+LLxgSiu3HcXJv2jQRtJc/Qn4=;
        b=i6r8YvDXi4a0KQJTONXncj4r1DAZmdbQ46CVf5QWF7naJfhE6apYHKEKTRrXXYkMAo
         DhiRitClUAFR4WOZTLEeVVbsGvPEDu/sO3LuGWKEFg4t5DSH1JLeiJhCZE0NSu3jih3x
         OpQZWmrQX/NaOxRZ26mfYDc2JBKSF05NjlA2egiSfTxn6cTNTNNmOyC8ZZNha+m0aMj6
         lCndrGdV1mUuqHANdrosk3vtM8ps+p2F3zsfWV7MZ3a9qntjPxAPep95xvpRGrwVoZbk
         +nOoBkmSdI5KPmTdjIUHT9VqqzQfAtzMjs4XR2vO8g+yLngNHejqoKQtibvC6Fbejx7Z
         +XfA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775320848; x=1775925648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZgA226Cmm4VCqAdwuhHb2i0vnYsqVsFbxRKzFOanx3U=;
        b=PZvCbKC/i/OlKtCu1VJg4xz4P6+JDgJ/DorttzTbkyxT8yEQV7YJ+DM6t15nqrapOu
         ZxDwmaus8SDd7rub+gnUsxE7VZgPCG4pOOwhjbxtd7T6pI/M0nWcllKLK8tYvaggv/kG
         k1Vo2gRP19hLEnAuMoz3hriT+WiZr2KpnASvlHUPx5CPAsaTaWGlgNx7dy5UbEIWBeY1
         aWmX0KCZfiyPILEPGb4F/aoI4iPObvreHcU6+Jug3kxoLr1+KgyvEvJ2oT+hwNohp9lI
         3PbW7GnH2nbTAcNpAqBerePGF046tSwRx3tW7DW7S6vhftlDzxyD+ikXFvGIjWjQ3BWh
         LkTg==
X-Gm-Message-State: AOJu0Yyy+y1eudWsC3tz7y3wLu+/YHN3UbPGyA8elIKp7pJcmY9prvrf
	IR+fYB7ZB2XuG20C52p+b6sAhabppzrLlcnZybvt6qi+A0emoabNJJaULITmSbZJxiz/Lkf+XNu
	5VqDsYd0D54HbeghsBgR7h7rkVbwgrTFtq67ReuJi+McUqcKXLERxw83drbtv7uqmdYUU73Tslh
	yRDyvF9xQDhJkOmJQJBArz2T5iYY3EmfGSaGT0LQ0Wxcyl6w==
X-Gm-Gg: AeBDiesMcBhoWCz9glnrQ7sJE+UtxvjHuKLt3y3JOKbTRItTuo+ZkUV7NDsFo/owPVo
	t9fBLECURcXfgxslMRrq8U8rCNajWCkdm+prjk1/84c3yAmYloyZl9yM3eUq32LWvc2sxJuftRP
	SunFbZew6W/8tXhDdxNZWURM80bbno02t1QhGM5TKaThaTRgrHzIwchaBWl9uqqMbrsr7BSsKKr
	MCnzCj8gU7pQku8ZXmYRc6MTgDcvwEeFc8ZA6wd8rGOFfhRJxAe69AfgyciISMkQSJ6Lhg=
X-Received: by 2002:a05:600c:3acf:b0:486:fc4a:2951 with SMTP id 5b1f17b1804b1-488997d51bfmr99327635e9.28.1775320847857;
        Sat, 04 Apr 2026 09:40:47 -0700 (PDT)
X-Received: by 2002:a05:600c:3acf:b0:486:fc4a:2951 with SMTP id
 5b1f17b1804b1-488997d51bfmr99327405e9.28.1775320847435; Sat, 04 Apr 2026
 09:40:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260331091901.219894-1-yphbchou0911@gmail.com> <dvn6mff3v7ypuf66iagmsuuqdnpi3cxfhnf56bp3s4a54i37sn@up6cwqvg6qov>
In-Reply-To: <dvn6mff3v7ypuf66iagmsuuqdnpi3cxfhnf56bp3s4a54i37sn@up6cwqvg6qov>
From: Emil Tsalapatis <etsal@meta.com>
Date: Sat, 4 Apr 2026 09:40:36 -0700
X-Gm-Features: AQROBzDGAAtU-BMUxEEPhesFvzYgc33ZKlmMA9Vz6v1igiA3TJnJtQ1tIiJXaiA
Message-ID: <CAMe2y=GthX0kD42FKWfdXMzSPQaajMvoersBHfNitNhTquVC2w@mail.gmail.com>
Subject: Re: [PATCH] tools/sched_ext: Fix off-by-one in scx_sdt payload zeroing
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>,
        David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
        Changwoo Min <changwoo@igalia.com>,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
        Chia-Ping Tsai <chia7712@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: sLHrJFVlCYSyGdoPw7mIyNP76UTC0ixH
X-Authority-Analysis: v=2.4 cv=NaXrFmD4 c=1 sm=1 tr=0 ts=69d13f11 cx=c_pps
 a=CsXZvLRfiTx/ye2xXAwb9g==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22
 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=CWErhr8FAAAA:8 a=4OgE2WNpP8yww339eGMA:9
 a=QEXdDO2ut3YA:10 a=F7q00xkr9EfWfQvbdVXI:22 a=I-g_0vLIplkVOQ0FYkeP:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDE1NyBTYWx0ZWRfX575OP8Z120n1
 Fo581STrz6gPYnBmbRvi+igqbPFngZQmGIBu95th8BilIVgbwGk5ofsB9QpNZQUCEofcQHKTf+g
 3f6fkFXrtP+6PK2ml5/SFku+saUOuyXuMReSetSPHalr6RaZ9fAbR62ah9GmhVV7m/hFYHC3bA9
 xiIE6XPuumlWL9LlWvTQsSr3kjCbfMosc7CdBmg6hAIbXKtoR15CQUmYElZXZM0/QorS/5aQNpA
 oX3CXjZrjFQdhC077GXTuXkY08YmOFSqDNX9NRcFHTWo/zQxHtHyGu6mZ4zco6vJ5oMOiC/AoqB
 qtZJ2qR5FpOHoTsUXxi3tCCXOO4nh1xLziL8prlwhY7ev7JberEHyNGKD36PFx9ki1JC3GPo1dk
 LS53nVm0rZrNfDvmBpadgeeB8MBkbXLEJESkeG4QoXM3T5pTSVOcFpH3WFbi0U/OyHSV+V034ND
 29FMX3gbeSg7E3Bxu5Q==
X-Proofpoint-ORIG-GUID: sLHrJFVlCYSyGdoPw7mIyNP76UTC0ixH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_02,2026-04-03_01,2025-10-01_01

On Fri, Apr 3, 2026 at 11:14=E2=80=AFPM Cheng-Yang Chou <yphbchou0911@gmail=
.com> wrote:
>
> >
> Hi all,
>
> On Tue, Mar 31, 2026 at 05:18:33PM +0800, Cheng-Yang Chou wrote:
> > --- a/tools/sched_ext/scx_sdt.bpf.c
> > +++ b/tools/sched_ext/scx_sdt.bpf.c
> > @@ -317,7 +317,8 @@ int scx_alloc_free_idx(struct scx_allocator *alloc,=
 __u64 idx)
> >               };
> >
> >               /* Zero out one word at a time. */
> > -             for (i =3D zero; i < alloc->pool.elem_size / 8 && can_loo=
p; i++) {
> > +             for (i =3D zero; i < (alloc->pool.elem_size - sizeof(stru=
ct sdt_data)) / 8
> > +                  && can_loop; i++) {
> >                       data->payload[i] =3D 0;
> >               }
>
> Same fix landed in upstream SCX:
> https://github.com/sched-ext/scx/commit/a01197a
>
> Minor, but it does address a real issue. Thanks!
>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> --
> Thanks,
> Cheng-Yang
>
