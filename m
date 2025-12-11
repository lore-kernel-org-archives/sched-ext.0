Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBB22DA765
	for <sched-ext@lists.linux.dev>; Thu, 11 Dec 2025 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765472964; cv=none; b=H4BDFvJUy79nvxKawC7IyA1IUdjJvOmH50ZHeoJy0OQUlrZNTm5A0h9ZZwkfbHjIkp1RtSym3d5vPXi+9QurgPug+ht0r0RYhW+7+L5fvA5tEgzE0G98gWouzRxbr7XUBsqlJszZTBinn9NOVLV44+Wta5AOpUrqHlMt0cXOyyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765472964; c=relaxed/simple;
	bh=dh/HDIXzktuGWQSITg9LVH40sJ2hdSzo5/AZggWSBpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zn0Wk1piE03rMGep/kJeJ59lwLv2HXvDWko0su1+yokrg30oByzv4vVQnol0hsQtRgZI9tAFLdnlP+hhUBUWdYcXeHZXLPAAOq/yGwjy5EjSaNVcQvtyWjUpzCzPI5kuexVzreDPoDaDOjyaoCcvQ/iYOcHLJEvMFUbqohsW3wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yvn00ufE; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yvn00ufE"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-455749af2e1so164560b6e.1
        for <sched-ext@lists.linux.dev>; Thu, 11 Dec 2025 09:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765472962; x=1766077762; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FW2VUCo7IK1n+Kn8KgoCJTzuM+/Fk/IPBhEby/pihF0=;
        b=Yvn00ufE0howOV1EA8c+Fcqph378md1ndPZ/xEYQ7T7n9SvnGGYHExOJzSi4Nr7IG6
         Whw/JcbDvsqmfGfw0ttW+VQoH2Il/P7znyArxoQNJY3U4YnFyHvAyuHdCXNhF4uJhMiA
         bYyfkoxsPstimtANxo75mjsi6QALwkctOW/n0ns6Y2GO4lDCiOx8jFZ7F959ftiBMBGa
         jZ3OkDcugPFLG3PlmQmjG71TS60qUk1zbud+WmsxpaX4PKqUClP/gil7TAtfsU4SWGVn
         yGhfVuE4Ys0ltvMxFj82+5MZyLJitbzXkTeMueKEUqqzqnK8MVT8ol01EMM8E17249ez
         eMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765472962; x=1766077762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FW2VUCo7IK1n+Kn8KgoCJTzuM+/Fk/IPBhEby/pihF0=;
        b=KAdNHIMmXORlF2GLXWec1IT3iI3Vc6VfzfGtt+kQTEthhRI/zbjzpXcoCMlUT8A1Eb
         RvVKqyQ1eizhyAAuqxXoonGJ8NZNP05RGB3uMrcsH2IuzSwpXWzIjBuzIn5VSd1hcRPN
         Uvri55PoL5L0lkYVMcxoRIe3hh65xlYRkTmx2niy+F6jA6IvMAdoiR36+qLU8bQP2tqw
         pX1iORuhcjmm9GKIZXf+48wRxzph1vgqG11fLXOqy4JZ9f1ZY9xyvwWMXeHiFBpfwi06
         a8HHXg03VglvMow57Kb0YZgElIQtHMIicwSUYQSyuvzPeiQA3lMYgvIuJxHh6drOY1G+
         NlKA==
X-Forwarded-Encrypted: i=1; AJvYcCUmE4SLTS9h0Z70aXCAlU4QSr+6A33t0XJubCSzKe1zWp+PUu5nTmLdcgoJSqglv4YWzV8Rj4TSMV0=@lists.linux.dev
X-Gm-Message-State: AOJu0YzpFJV0yQBD1HaiuLEKmRKoxEdeU2AcCzaDk9RnWhwgqTHUHmkc
	aWF9FYINvIwyFjKVTZmsVOH4JmSGJzoE9u9yOZslzMKlwXoQFRknthcXKyPN4yb7chWeGe6nC7f
	+hK95csYAZTp+yGEUbosJZsO02Cjrhis=
X-Gm-Gg: AY/fxX50S5emx2DloYfiH6UeCdse3H1DJ6Wa41BlzbDhOjcB5YvUbdEUBOX8V9O5dtR
	n0CBXQ+1ekI97GzaALz04jNzePUqNXvj/VQ2Ffi5xvBrL3l+tTsUiAm8sgaRZVhd4xOaNyQODYa
	1w6WpBMRvdNYDKiaaZieVIrBYyvulw2c4V6EAadFIlF0WcUVbgzLGi2xbSUYRzsD3fwI5fr0Jxc
	kP7+FzYgV2d6IsC6D14xX17tAO0JNPW284LrXjAKeoPkJyndaxtMfHPWowQ9ujVinB/EmkbNweI
	tAFUaZahQTNDDOGr9nB8ZH4AIA==
X-Google-Smtp-Source: AGHT+IFxpPbCdRMZz9XBjuHDTCZ9dsvF1etOQHeAP0z0LVfgm/LsQx3fse+ZuSSLzWCYXnUik92Z0mf6l8CpZRvS100=
X-Received: by 2002:a05:6808:470a:b0:453:5e88:29b9 with SMTP id
 5614622812f47-4559bf4860dmr1211437b6e.28.1765472961939; Thu, 11 Dec 2025
 09:09:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAD4GDZy-aeWsiY=-ATr+Y4PzhMX71DFd_mmdMk4rxn3YG8U5GA@mail.gmail.com>
 <fc7dede0-30a4-4b37-9d4c-af9e67e762c7@lunn.ch>
In-Reply-To: <fc7dede0-30a4-4b37-9d4c-af9e67e762c7@lunn.ch>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Thu, 11 Dec 2025 17:09:10 +0000
X-Gm-Features: AQt7F2qtonLBE9deAK2-llt-SKUXbtrFWqqvYj6_-uA64Lmu8yrBroU6XbFO-mo
Message-ID: <CAD4GDZxYVwzxHBRnpG1RnkaD3wPW+-GUozhBg7hzO-_3X_PPpA@mail.gmail.com>
Subject: Re: Concerns with em.yaml YNL spec
To: Andrew Lunn <andrew@lunn.ch>
Cc: Changwoo Min <changwoo@igalia.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	sched-ext@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Dec 2025 at 17:04, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Dec 11, 2025 at 03:54:53PM +0000, Donald Hunter wrote:
> > Hi,
> >
> > I just spotted the new em.yaml YNL spec that got merged in
> > bd26631ccdfd ("PM: EM: Add em.yaml and autogen files") as part of [1]
> > because it introduced new yamllint reports:
> >
> > make -C tools/net/ynl/ lint
> > make: Entering directory '/home/donaldh/net-next/tools/net/ynl'
> > yamllint ../../../Documentation/netlink/specs
> > ../../../Documentation/netlink/specs/em.yaml
> >   3:1       warning  missing document start "---"  (document-start)
> >   107:13    error    wrong indentation: expected 10 but found 12  (indentation)
> >
> > I guess the patch series was never cced to netdev or the YNL
> > maintainers so this is my first opportunity to review it.
>
> Maybe submit a patch to this:
>
> YAML NETLINK (YNL)
> M:      Donald Hunter <donald.hunter@gmail.com>
> M:      Jakub Kicinski <kuba@kernel.org>
> F:      Documentation/netlink/
> F:      Documentation/userspace-api/netlink/intro-specs.rst
> F:      Documentation/userspace-api/netlink/specs.rst
> F:      tools/net/ynl/
>
> adding
>
> F:      Documentation/netlink/specs

It is covered by the Documentation/netlink/ entry:

./scripts/get_maintainer.pl Documentation/netlink/specs/em.yaml
Lukasz Luba <lukasz.luba@arm.com> (maintainer:ENERGY MODEL)
"Rafael J. Wysocki" <rafael@kernel.org> (maintainer:ENERGY MODEL)
Donald Hunter <donald.hunter@gmail.com> (maintainer:YAML NETLINK (YNL))
Jakub Kicinski <kuba@kernel.org> (maintainer:YAML NETLINK (YNL))
[...]

>
> I'm also surprised there is no L: line in the entry.

That's something we should address, thanks!
