Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B1A285C89
	for <sched-ext@lists.linux.dev>; Tue, 20 Jan 2026 01:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768873766; cv=none; b=VC1uqNGsZYAQcuNCjA0rb0HAtyJFANJUSadMngEpHdbByBkRx9DFeZTQOzR7HINPtfIT2ofq3a1StzcSb8PRerPeUOEhoWH9aao0YeUFlqaCsLeNQxBbQmH5BReJbFBTiq1riBba5/Lsf0Az/cAXer3xKvNnFSAjDrgsoh27lUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768873766; c=relaxed/simple;
	bh=P4vH0k+7XsEwT791gaUby6dSyltbIn6BS1tA5QY+bp0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=On4H8GrU1yPpvWFrEqTji6WM+Q3lRsrIZjGF8dHLOXRDYyBbLMHN/VUkONXxN7pDeJFTh8396H8dqHEuzgKHCMEQ76UrmajeXXBTa/2yBuus6aO8TG8yDJoALwQST8691oOg0LOXZsZinpBaIMuK/jymdSEPvFBwTKUc3a899Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rb1uAIAQ; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rb1uAIAQ"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b6f5a9cecaso824499eec.0
        for <sched-ext@lists.linux.dev>; Mon, 19 Jan 2026 17:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768873748; x=1769478548; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xjg5AkPxw0MOdaWLN3zWHsbO0Z52mOb9jRmich2qKiA=;
        b=Rb1uAIAQTL3IpX/RXrQaURYpfJT+kwL7C4Mh5Hnbd3ebawrt/3deLeVreOAFD0W/Zu
         xDYZ0t9UNeoXKgX6NSIBCCtYFvDlMOyFoKpouR2WBebSXidbsVt3LfJ/yHOcEO5mTNv9
         65/N8l5el7VxEI4hn5sBae33eYorZTz/ce0H5GfA0JwidMMx9CC18E4AEBxT+0LCrn9N
         g/LyqSIAPrIgftldxW8iAvQEwQql0lhluMle/E7x4Xf7Q4KCscIxx3JSqWDyZyLtr+la
         n8zYjzfor/Tc1PDbs/sWr2XX7lV3HZkaDWX+RvvJKUZhdJKcFYyofIbH5o5jIbnHax50
         KPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768873748; x=1769478548;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjg5AkPxw0MOdaWLN3zWHsbO0Z52mOb9jRmich2qKiA=;
        b=wxsxqkCJKriywbCCRoZ8Hh/E6D3xJ2RdpMLHWIEM6cngOvowb4nL+EC70puEYllSJ3
         MhFrVoP+NcmEiNTBNgq6R2P1enzoRCBv7uXvzA32s2l60JBV/4WSkMCTwe/Svojv+GAW
         kRfKfjx8/U5lq8BMMsQlbpHPfOdoqjy/WfruAHdf8YsCL8VMrif6as85a9OtkHRU8eOu
         zrpQ9il8SYVAIoTdKSS+zyNG2ZuGR0qCeSOd2CihPOPJ/M5moz/dd21xF/3nxguouXcA
         PTZaNGa8AzBYnZGHRYCHZ8KTplKTClYicaM7IYHN/5W8g1sZdjUD7j5L3TfjPmkOe7Bj
         CfIw==
X-Forwarded-Encrypted: i=1; AJvYcCXlTEQ2wUge/etOiro9XVpL2dzzIy0Elpv+GFAcSZ8a4Ct6RsDizRqsRsPjvfHjAwjNRPS/HxtdYOc=@lists.linux.dev
X-Gm-Message-State: AOJu0YzmARB6T74yzrhmKcRjHIR2QV/4ty8mMcwXqXL762SZYSqZclad
	Hme2an3mP2hlpA8/DONkAH4Di3n3HSwSEnvOqN4R4uhgWSN/iR/AV8+i
X-Gm-Gg: AZuq6aLVyliWGfwgf+sBzva52o5j89SfmGx3nnkn5pBPJZ1WXyEkKL4+hnvVajphauf
	nWtihvvT9SmCrMVKX6HyRzkvuZvXsv0QT6YD8IIL8UQ4qv8ErTY4WXWd87GH60iwedOSS8nvzSr
	BsQrO9VZSkrJ//UCzkp/yOa+yYSvZgMNfOcQQySktp18P4KX5fmc5xqXEREyN5c/jk0lFqsg28U
	zX8Rp+wlJMDCtPLMhKfMvJ+naXuNu0EfA2PCBoFbT/z5fQRELiXgwwJzjTk+71urUu1JPtLQDO0
	uut0UHnDIQR8gEItiC3vujWw5qX12RMqVz8hOvV82KigJSLkJeSUUiLdy4jr5SSfZN5uA7/tXsm
	NEqsKp2r+kK40Jhd7yrFdRSQMt15HxNISJeQrct+8HtnrAujWy8gXX9dQy6YWHYJD/u4IIQVhC8
	Pf7zudKMxGIxT7HOeTU0TlBVzNl/lAMfRBxXLYSmU3nZ/FvlvyKLNYOFa/4x4cswt/2w==
X-Received: by 2002:a05:7300:c608:b0:2ab:c279:9dce with SMTP id 5a478bee46e88-2b6fd623ef7mr293270eec.7.1768873747978;
        Mon, 19 Jan 2026 17:49:07 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502d22sm15327177eec.10.2026.01.19.17.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 17:49:07 -0800 (PST)
Message-ID: <088b071d1a43b403123d772f56ce033e91cb4252.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 00/13] bpf: Kernel functions with
 KF_IMPLICIT_ARGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, 	sched-ext@lists.linux.dev
Date: Mon, 19 Jan 2026 17:49:05 -0800
In-Reply-To: <20260116201700.864797-1-ihor.solodrai@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Fri, 2026-01-16 at 12:16 -0800, Ihor Solodrai wrote:

[...]

> v1->v2:
>   - Replace the following kernel functions with KF_IMPLICIT_ARGS version:
>     - bpf_stream_vprintk_impl -> bpf_stream_vprintk
>     - bpf_task_work_schedule_resume_impl -> bpf_task_work_schedule_resume
>     - bpf_task_work_schedule_signal_impl -> bpf_task_work_schedule_signal
>     - bpf_wq_set_callback_impl -> bpf_wq_set_callback_impl

Just to clarify my understanding, this is a breaking change, right?
E.g. bpf_stream_vprintk_impl is no longer in vmlinux.h and on a load
attempt an error is reported:

  kfunc 'bpf_stream_vprintk_impl' is referenced but wasn't resolved

Maybe call it out explicitly in the cover letter?
