Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE5C492502
	for <sched-ext@lists.linux.dev>; Fri,  2 Oct 2026 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790941726; cv=none; b=E2B4YivbVmtmmy+PyUQAPj4pkdMDz1eam1X1r5gjI3JldTD/JIWY+za2fkN+j1Bhz/0HmWwKa9XG1fuYO3qIWmQ2T1vk/sQFY+0foW0/ZMRVWNajk55wz0sGnezWeHJ7rVKBcUFTFOOx4JuObQy1l3HgZ1wIh8zH9G2fGvvhhco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790941726; c=relaxed/simple;
	bh=gAY+ry7XQppx5kZcg+BfzcVwDqxF38v68qrWhv2EpEU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=tQA3fEyr+hko+IG3QMNoUdeni3G6oeKl6CU15R0TsBdqO7jV4lM2foPyZPRBTgHsIp+XP9Emt6JB60PPgX5iuj2auXGFl3u0HRQzmYmjCqgPmgYOJjHDaq73IQ91ZucjlPaN+oTbMhSSJFvymKsxYQRwIG8REOfbbkZk8t6DWsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTaokq61; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTaokq61"
Received: by mail-pz2-f37.google.com with SMTP id 41be03b00d2f7-cc7cadbe09cso2336468a12.1
        for <sched-ext@lists.linux.dev>; Fri, 02 Oct 2026 04:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790941724; x=1791546524; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jDgCZ93FbbC+h+9QAZpC0c3CaTDV4NHqwfDJ+8l3w7I=;
        b=lTaokq619009GSMmtkS/cAVbCdLZl3+7Kw6MfrjyogaJGOuSw3Ceveoqo8Ds5lcfan
         ci4P8TDmgphKFec/Z3wp2qo81ReiVbm5ATmslbA9k0dPkzulk9VC2JxkgX9NjRYXqe9D
         hFtDkgelj+HcgEEgsAuhqa4TcEa4ML0ZpT9zzCiyoH6ADX8GUQe5TTuRaJlM6SNrlV17
         Te4NiE3ZzhAw4TV3JTBFwjmpNOYeP8j7UC/nh1sZH3Q6Av/fvGFro5YTn1oUGAyTf8dP
         /qPTe/aQod53MidrxQflDN9krG7EDf8wm4BUcWP8oAeV92BXAneEsLrVR+zkEuLnF6zy
         BlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790941724; x=1791546524;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jDgCZ93FbbC+h+9QAZpC0c3CaTDV4NHqwfDJ+8l3w7I=;
        b=wE5qifXafnP/YmvdE4eKyWt30Mhyv5SlBZmZYBNLpIoA6VtMX0OVqI7yRZy3MFeW/8
         7parFrikL/84QQBo8xHwifV/U12BcV7YKnLQfdH45zGHexdC3UYfnCo0ypU5kz//drmx
         yUm2F0n/4q98dJKDqHMprfKPFW7gynsbjyZNjZIOl4qveTQhBex0gQ3Tz8S/mWUEZZtr
         0zzOXpg18ZTaMNeeJ9SixMHDIvlHvo+jevabWBgVCEDFVKy7wiumFfU7D2FVjqlhszSR
         00BXXIwDbHBIYPfgQ3XVDXL7wkJXTdJYqz3jm5QCCHQ5jJzp1Cmu8cY4hVMkDpIRzjtV
         +GIA==
X-Forwarded-Encrypted: i=1; AKwUvBypUsNBj0RJJAKYpdiToz9SXlP5iOGX4sH000QIr32b70nFL535VIbZ6/aviv24Ve/5ANB4go4LOVA=@lists.linux.dev
X-Gm-Message-State: AFuF++lSEe8Q/i1vOlrTyGVpU6UvqR65hx7kmgs80hTwwysDBfCocX3R
	XN37e1EL/luPnirXigGrL9cbmkmzuX6IUb+TorPhbhae0PnhasJahTuC
X-Gm-Gg: AYBFou3h7OMv6JZSUQQc0fVuA/gNwcOpmpO2uzoK42KHoN/Ma+5pEoDNyBpaqQAXcZA
	Z1Mqk7Tme1POFWxVs4G+5d9SXNTvbhApZwWgsz9sceZRC/OovB/lFjvhhwV+G075l69U6WUuXz2
	Rz9i69Rif62LqIxsGUenP18fmYQ/BKu114FB6uigTxhuSaqVazRT6BMwVGZE/hMBkp2yUrq56im
	hV5pWX9fdvWbn+eK5Ct2MlzE7ExLWVLG3qp9sPNa5xm3aM8ANmNEGVBA0VcWAkuqfILUn6vfs04
	adxLh+JARU+X1WhtdlkDednivY0vNj+hwQBxCenb/v7OBXDti7UjYWekJsViTx8b17MBTr1v/DH
	SH552DGONF+5b7d17N1qV2cuMeHpxKVBgouESGdixXIVrsFn8p+fNqdj7mCeNiSgKSdkIK28nff
	tgqnG7RkeWJMXZ4GW0SNKxLfANsL9GaHLAtehhNF41f6DR8c0a5mi5f687vKKUdChmFyPsQKdsd
	U3r7KHcZsAKOyY8iBm8bVzCk+X1yyCW9THnULjtfvR74xA/74Rmo9MZJ0EO/IRPe1wk7Yevt0ph
	VOY=
X-Received: by 2002:a05:6300:210a:b0:3e0:b937:8844 with SMTP id adf61e73a8af0-3e0bd199342mr2548048637.44.1790941723843;
        Fri, 02 Oct 2026 04:48:43 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0d247dbcsm743396b3a.55.2026.10.02.04.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 04:48:43 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Oct 2026 11:48:42 +0000
Message-Id: <DLUBUT40BBOG.1L6QS7A8CIE79@gmail.com>
Cc: "Alan Maguire" <alan.maguire@oracle.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 "Quentin Monnet" <qmo@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>,
 "Nicolas Schier" <nsc@kernel.org>, <linux-kbuild@vger.kernel.org>,
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, "Christian
 Heusel" <christian@heusel.eu>, "Luis Chamberlain" <mcgrof@kernel.org>,
 "Petr Pavlu" <petr.pavlu@suse.com>, "Sami Tolvanen"
 <samitolvanen@google.com>, <linux-modules@vger.kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, "Arnaldo Carvalho de Melo"
 <acme@kernel.org>, "Namhyung Kim" <namhyung@kernel.org>, "Ian Rogers"
 <irogers@google.com>, <linux-perf-users@vger.kernel.org>, "Jiri Kosina"
 <jikos@kernel.org>, "Benjamin Tissoires" <bentiss@kernel.org>,
 <linux-input@vger.kernel.org>, "Tejun Heo" <tj@kernel.org>, "David Vernet"
 <void@manifault.com>, "Andrea Righi" <arighi@nvidia.com>, "Changwoo Min"
 <changwoo@igalia.com>, <sched-ext@lists.linux.dev>, "Shuah Khan"
 <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, <rust-for-linux@vger.kernel.org>, "Arnd Bergmann"
 <arnd@arndb.de>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Hazem Mohamed Abuelfotoh"
 <abuehaze@amazon.com>, "Bjoern Doebel" <doebel@amazon.de>, "Martin Pohlack"
 <mpohlack@amazon.de>, <jay.wang.upstream@gmail.com>
Subject: Re: [PATCH bpf-next v4 04/12] bpf: take the vmlinux BTF from the
 btf_vmlinux module
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jay Wang" <wanjay@amazon.com>, <bpf@vger.kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
In-Reply-To: <20261001225214.12351-5-wanjay@amazon.com>
References: <20261001225214.12351-1-wanjay@amazon.com> <20261001225214.12351-5-wanjay@amazon.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Thu, Oct 01, 2026 at 10:52 PM Jay Wang <wanjay@amazon.com> wrote:
> +	err = __sys_bpf(cmd, USER_BPFPTR(uattr), size, USER_BPFPTR(uattr_common), size_common);
> +	if (IS_MODULE(CONFIG_DEBUG_INFO_BTF) && err < 0 && bpf_btf_vmlinux_retry(cmd, misses))
> +		err = __sys_bpf(cmd, USER_BPFPTR(uattr), size, USER_BPFPTR(uattr_common),
> +				size_common);

Running the command twice when it failed and a global counter moved
is not going to fly.
Missing BTF is not always an error.
With =m and BTF not loaded yet take
  int prog(struct xdp_md *ctx)
with func_info. That is everything libbpf loads.
do_check_common() calls btf_prepare_func_args(env, 0).
find_canonical_prog_ctx_type() returns NULL, btf_is_prog_ctx_type()
returns false, the arg becomes ARG_PTR_TO_MEM and
func_info_aux[0].unreliable is set.
The prog loads. err == 0. No retry.
From then on freplace of that prog fails with
"Cannot replace static functions" and fentry/fexit see its args
as scalars, even after BTF is loaded.
With =y both work.

That is the only reason why "a socket filter does not load it".
In v3 such prog loaded BTF.
systemd built with BPF_FRAMEWORK loads
  int sd_bind4(struct bpf_sock_addr *ctx)
from manager_setup_cgroup() at every boot.

The result of the verification cannot depend on who touched BTF first.

bpf-ci is right too. The first run writes into uattr.

It's starting to feel that this is dead end.
So much complexity to save few Mbyte.

pw-bot: cr
